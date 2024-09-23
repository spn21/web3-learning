// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "forge-std/Test.sol"; 
import "../src/3.sol"; 

contract FunctionTypesTest is Test {
    FunctionTypes public functionTypes;

    function setUp() public {
        functionTypes = new FunctionTypes{value: 1 ether}(); 
    }

    function testAdd() public {
        functionTypes.add();
        assertEq(functionTypes.number(), 6);
    }
    function testAddPure() public {
        uint256 result = functionTypes.addPure(5);
        assertEq(result, 6); 
    }

    function testAddView() public {
        uint256 result = functionTypes.addView();
        assertEq(result, 6); 
    }

    function testMinuCall() public {
        functionTypes.add(); 
        functionTypes.minuCall(); 
        assertEq(functionTypes.number(), 5); 
    }

    function testMinusPayable() public payable {
        functionTypes.add(); 
        uint256 balance = functionTypes.minusPayable{value: 0.1 ether}(); 
        assertEq(functionTypes.number(), 5); 
        assertEq(balance, 1.1 ether); 
    }
}
