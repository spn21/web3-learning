// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/45Timelock.sol";

contract TimelockTest is Test {
    Timelock public timelock;
    address public admin;
    address public newAdmin;
    uint public constant DELAY = 2 days;

    function setUp() public {
        admin = address(this);
        newAdmin = address(0x1);
        timelock = new Timelock(admin, DELAY);
    }

    function testInitialState() public {
        assertEq(timelock.admin(), admin);
        assertEq(timelock.delay(), DELAY);
    }

    function testQueueAndExecuteTransaction() public {
        // 模拟一个要执行的函数
        bytes memory data = abi.encodeWithSignature("setPendingAdmin(address)", newAdmin);
        uint eta = block.timestamp + DELAY;

        // 队列交易
        bytes32 txHash = timelock.queueTransaction(address(timelock), 0, "setPendingAdmin(address)", data, eta);
        assertTrue(timelock.queuedTransactions(txHash));

        // 尝试过早执行
        vm.expectRevert("Timelock::executeTransaction: Transaction hasn't surpassed time lock.");
        timelock.executeTransaction(address(timelock), 0, "setPendingAdmin(address)", data, eta);

        // 等待延迟时间
        vm.warp(eta);

        // 执行交易
        timelock.executeTransaction(address(timelock), 0, "setPendingAdmin(address)", data, eta);
        assertEq(timelock.pendingAdmin(), newAdmin);
    }

    function testCancelTransaction() public {
        bytes memory data = abi.encodeWithSignature("setPendingAdmin(address)", newAdmin);
        uint eta = block.timestamp + DELAY;

        // 队列交易
        bytes32 txHash = timelock.queueTransaction(address(timelock), 0, "setPendingAdmin(address)", data, eta);
        assertTrue(timelock.queuedTransactions(txHash));

        // 取消交易
        timelock.cancelTransaction(address(timelock), 0, "setPendingAdmin(address)", data, eta);
        assertFalse(timelock.queuedTransactions(txHash));
    }

    function testSetDelay() public {
        uint newDelay = 3 days;
        bytes memory data = abi.encodeWithSignature("setDelay(uint256)", newDelay);
        uint eta = block.timestamp + DELAY;

        // 队列设置新延迟的交易
        timelock.queueTransaction(address(timelock), 0, "setDelay(uint256)", data, eta);

        // 等待延迟时间
        vm.warp(eta);

        // 执行交易
        timelock.executeTransaction(address(timelock), 0, "setDelay(uint256)", data, eta);
        assertEq(timelock.delay(), newDelay);
    }

    function testAcceptAdmin() public {
        // 首先设置待定管理员
        bytes memory data = abi.encodeWithSignature("setPendingAdmin(address)", newAdmin);
        uint eta = block.timestamp + DELAY;

        timelock.queueTransaction(address(timelock), 0, "setPendingAdmin(address)", data, eta);
        vm.warp(eta);
        timelock.executeTransaction(address(timelock), 0, "setPendingAdmin(address)", data, eta);

        // 切换到新管理员
        vm.prank(newAdmin);
        timelock.acceptAdmin();

        assertEq(timelock.admin(), newAdmin);
        assertEq(timelock.pendingAdmin(), address(0));
    }

    function testFailExecuteExpiredTransaction() public {
        bytes memory data = abi.encodeWithSignature("setPendingAdmin(address)", newAdmin);
        uint eta = block.timestamp + DELAY;

        // 队列交易
        timelock.queueTransaction(address(timelock), 0, "setPendingAdmin(address)", data, eta);

        // 等待超过宽限期
        vm.warp(eta + timelock.GRACE_PERIOD() + 1);

        // 尝试执行过期交易，应该失败
        vm.expectRevert("Timelock::executeTransaction: Transaction is stale.");
        timelock.executeTransaction(address(timelock), 0, "setPendingAdmin(address)", data, eta);
    }
}