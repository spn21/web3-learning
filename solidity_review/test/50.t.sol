// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "forge-std/Test.sol";
import "../src/50.sol";

contract MultiSigWalletTest is Test {
    MultiSigWallet public wallet;
    address[] public owners;
    uint public required = 2;

    address public owner1 = address(1);
    address public owner2 = address(2);
    address public owner3 = address(3);

    function setUp() public {
        owners = [owner1, owner2, owner3];
        wallet = new MultiSigWallet(owners, required);
    }

    function testConstructor() public {
        assertEq(wallet.owners(0), owner1);
        assertEq(wallet.owners(1), owner2);
        assertEq(wallet.owners(2), owner3);
        assertEq(wallet.required(), required);
    }

    function testDeposit() public {
        uint amount = 1 ether;
        (bool success,) = address(wallet).call{value: amount}("");
        assertTrue(success);
        assertEq(address(wallet).balance, amount);
    }

    function testSubmitTransaction() public {
        vm.prank(owner1);
        wallet.submit(address(4), 0.5 ether, "");
        (address to, uint value, bytes memory data, bool executed) = wallet.transactions(0);
        assertEq(to, address(4));
        assertEq(value, 0.5 ether);
        assertEq(data, "");
        assertFalse(executed);
    }

    function testApproveAndExecuteTransaction() public {
        address recipient = address(4);
        uint amount = 0.5 ether;
        
        // Fund the wallet
        (bool success,) = address(wallet).call{value: 1 ether}("");
        require(success, "Funding failed");

        // Submit transaction
        vm.prank(owner1);
        wallet.submit(recipient, amount, "");

        // Approve by owner1 and owner2
        vm.prank(owner1);
        wallet.approve(0);
        vm.prank(owner2);
        wallet.approve(0);

        // Execute transaction
        vm.prank(owner3);
        wallet.execute(0);

        // Check recipient balance
        assertEq(recipient.balance, amount);

        // Check transaction status
        (,,,bool executed) = wallet.transactions(0);
        assertTrue(executed);
    }

    function testRevokeApproval() public {
        // Submit transaction
        vm.prank(owner1);
        wallet.submit(address(4), 0.5 ether, "");

        // Approve and then revoke
        vm.startPrank(owner2);
        wallet.approve(0);
        assertTrue(wallet.approved(0, owner2));
        wallet.revoke(0);
        assertFalse(wallet.approved(0, owner2));
        vm.stopPrank();
    }
}