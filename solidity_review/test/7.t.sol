pragma solidity ^0.8.21;

import "forge-std/Test.sol";
import "../src/7.sol";

contract MappingTest is Test {
    Mapping public mappingContract;

    function setUp() public {
        mappingContract = new Mapping();
    }

    function testInitialMappingValue() public {
        assertEq(mappingContract.idToAddress(0),address(0));
        assertEq(mappingContract.idToAddress(0),address(0));
        assertEq(mappingContract.swapPair(address(this)),0);
    }

    function testWriteMap() public {
        uint testKey = 42;
        address testValue = address(0x1234567890123456789012345678901234567890);
        mappingContract.writeMap(testKey,testValue);

        assertEq(mappingContract.idToAddress(testKey),testValue);
    }

    function testMultipleWrites() public {
        address[] memory testAddress = new address[](3);
        testAddress[0] = address(0x1111111111111111111111111111111111111111);
        testAddress[1] = address(0x2222222222222222222222222222222222222222);
        testAddress[2] = address(0x3333333333333333333333333333333333333333);

        for(uint i =0; i<testAddress.length;i++) {
            mappingContract.writeMap(i,testAddress[i]);

        }

        for(uint i =0;i< testAddress.length;i++) {
            assertEq(mappingContract.idToAddress(i),testAddress[i]);
        }
    }

    function testOverwrite() public {
        uint testKey = 99;
        address testValue1 = address(0x4444444444444444444444444444444444444444);
        address testValue2 = address(0x5555555555555555555555555555555555555555);
    

    mappingContract.writeMap(testKey,testValue1);
    assertEq(mappingContract.idToAddress(testKey),testValue1);

    mappingContract.writeMap(testKey,testValue2);
    assertEq(mappingContract.idToAddress(testKey),testValue2);
}   

function teestchangedSwapPair() public {
    address testAddress = address(6666666666666666666666666666666666666666);

    assertEq(mappingContract.swapPair(testAddress),0);

    mappingContract.writeMap(1,testAddress);

    assertEq(mappingContract.swapPair(testAddress),0);
    }
}   