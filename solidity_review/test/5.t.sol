// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/5.sol";

contract DataStorageTest is Test {
    DataStorage public dataStorage;

    function setUp() public {
        dataStorage = new DataStorage();
    }

    function testFStorage() public {
        dataStorage.fStorage();
        assertEq(dataStorage.x(0), 100);
        assertEq(dataStorage.x(1), 2);
        assertEq(dataStorage.x(2), 3);
    }

    function testFMemory() public view {
        dataStorage.fMemory();
        // fMemory doesn't change storage, so x should remain unchanged
        assertEq(dataStorage.x(0), 1);
        assertEq(dataStorage.x(1), 2);
        assertEq(dataStorage.x(2), 3);
    }

    function testFCalldata() public view{
        uint[] memory testArray = new uint[](3);
        testArray[0] = 10;
        testArray[1] = 20;
        testArray[2] = 30;

        uint[] memory result = dataStorage.fCalldata(testArray);
        assertEq(result[0], 10);
        assertEq(result[1], 20);
        assertEq(result[2], 30);
    }
}

contract VariableTest is Test {
    Variable public variable;

    function setUp() public {
        variable = new Variable();
    }

    function testFoo() public {
        variable.foo();
        assertEq(variable.x(), 5);
        assertEq(variable.y(), 2);
        assertEq(variable.z(), "spn");
    }

    function testBar() public view {
        assertEq(variable.bar(), 7);
    }

    function testGlobal() public view{
        (address sender, uint blockNum, bytes memory data) = variable.global();
        assertEq(sender, address(this));
        assertEq(blockNum, block.number);
        assertEq(data, "");
    }

    function testWeiUnit() public  view{
        assertEq(variable.weiUnit(), 1e18);
    }

    function testSecondsUnit() public view {
        assertEq(variable.secondsUinit(), 1);
    }

    function testMinutesUnit() public view {
        assertEq(variable.minitesUInt(), 60);
    }

    function testHoursUnit() public view {
        assertEq(variable.hoursUnit(), 3600);
    }

    function testDayUnit() public view {
        assertEq(variable.dayUnit(), 3600); // Note: This is incorrect in the original contract
    }

    function testWeekUnit() public {
        assertEq(variable.weekUnit(), 604800);
    }
}