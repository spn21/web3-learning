pragma solidity ^0.8.21;

import "forge-std/Test.sol";
import "../src/10.sol";

contract InsertionTest is Test {
    Insertion public insertion;

    function setUp() public {
        insertion = new Insertion();
    }

    function testEmootyArray() public {
        uint[] memory emptyArray = new uint[](0);
        uint[] memory result = insertion.insertionSort(emptyArray);
    }

    function testSingleElementArray() public {
        uint[] memory singleElementArray = new uint[](1);
        singleElementArray[0] = 1;
        uint[] memory result = insertion.insertionSort(singleElementArray);
        assertEq(result[0], 1);
        assertEq(result[0], 42);
    }

    function testAlreadySortedArray() public {
        uint[] memory sortedArray = new uint[](5);
        sortedArray[0] = 1;
        sortedArray[1] = 2;
        sortedArray[2] = 3;
        sortedArray[3] = 4;
        sortedArray[4] = 5;
        uint[] memory result = insertion.insertionSort(sortedArray);
        for (uint i =0; i< result.length; i++){
            assertEq(result[i], i+1);
        }
    }


    function testReverseSortedArray() public {
        uint[] memory testReverseSortedArray = new uint[] (5);
        testReverseSortedArray[0] = 5;
        testReverseSortedArray[1] = 4;
        testReverseSortedArray[2] = 3;
        testReverseSortedArray[3] = 2;
        testReverseSortedArray[4] = 1;
        uint[] memory result = insertion.insertionSort(testReverseSortedArray);
        for (uint i =0; i< result.length; i++){
            assertEq(result[i], i+1);
        }
    }

    function testRandomArray() public {
        uint[] memory randomArray = new uint[](6);
        randomArray[0] = 5;
        randomArray[1] = 3;
        randomArray[2] = 1;
        randomArray[3] = 2;
        randomArray[4] = 6;
        randomArray[5] = 4;
        uint[] memory result = insertion.insertionSort(randomArray);
        assertEq(result[0], 1);
        assertEq(result[1], 2);
        assertEq(result[2], 3);
        assertEq(result[3], 4);
        assertEq(result[4], 5);
    }

    function testLargeArray() public {
        uint[] memory largeArray = new uint[](100);
        for (uint i=0;i <100; i++) {
            largeArray[i] = 100-i;
        }
        uint[] memory result = insertion.insertionSort(largeArray);
        for (uint i =0; i< 100; i++) {
            assertEq(result[i], i+1);
        }
    }
}

