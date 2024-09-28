// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "forge-std/Test.sol";
import "../src/11.sol";

contract OwnerTest is Test {
    Owner public ownerContract;
    address public initialOwner;
    address public newOwner;

    function setUp() public {
        initialOwner = address(this);
        ownerContract = new Owner(initialOwner);
        newOwner = address(0x114514);
    }

    function testInitialOwner() public {
        assertEq(ownerContract.owner(), initialOwner);
    }
    /*
    function testChangeOwner() public {
        ownerContract.changeOwner(newOwner);
        assertEq(ownerContract.owner(), newOwner);
    }

    function testChangeOwnerNotOwner() public {
        vm.prank(address(0x5678));
        vm.expectRevert();
        ownerContract.changeOwner(newOwner);
    }

    function testChangeOwnerToZeroAddress() public {
        vm.expectRevert();
        ownerContract.changeOwner(address(0));
    }

    function testOnlyOwnerModifier() public {
        vm.prank(address(0x5678));
        vm.expectRevert();
        ownerContract.changeOwner(newOwner);
    }

    function testChangeOwnerMultipleTimes() public {
        address newerOwner = address(0x5678);

        ownerContract.changeOwner(newOwner);
        assertEq(ownerContract.owner(), newOwner);

        vm.prank(newOwner);
        ownerContract.changeOwner(newerOwner);
        assertEq(ownerContract.owner(), newerOwner);
    }

    function testChangeOwnerEvent() public {
        vm.expectEmit(true, true, false, true);
        emit OwnerChanged(initialOwner, newOwner);
        ownerContract.changeOwner(newOwner);
    }
    */
}


//event OwnerChanged(address indexed previousOwner, address indexed newOwner);