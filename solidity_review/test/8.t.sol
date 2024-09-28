/*pragma solidity ^0.8.21;

import "forge-std/Test.sol";
import "../src/7.sol";

contract InitialValueTest is Test {
    InitialValue public initialValue;

    function setUp() public {
        initialValue = new InitialValue();
    }

    function testInitialValueTypes() public {
        assertEq(initialValue._bool(), false);
        assertEq(initialValue._string(), "");
        assertEq(initialValue._int(), 0);
        assertEq(initialValue._uint(), 0);
        assertEq(initialValue._address(), address(0));
    }

    function testInitialEnum() public {
        assertEq(uint(initialValue._enum()), 0);
    }

    function testInitialStaticArray() public {
        for (uint i = 0; i < 8; i++) {
            assertEq(initialValue._staticArray(i), 0);
        }
    }

    function testInitialDynamicArray() public {
        assertEq(initialValue._dynamicArray().length, 0);
    }

    function testInitialMapping() public {
        assertEq(initialValue._mapping(0), address(0));
        assertEq(initialValue._mapping(1), address(0));
        assertEq(initialValue._mapping(type(uint).max), address(0));
    }

    function testInitialStruct() public {
        (uint256 id, uint256 score) = initialValue.student();
        assertEq(id, 0);
        assertEq(score, 0);
    }

    function testDeleteOperator() public {
        assertTrue(initialValue._bool2());
        initialValue.d();
        assertFalse(initialValue._bool2());
    }

    function testFunctionsExist() public {
        assertTrue(address(initialValue).code.length > 0);
    }
}
*/