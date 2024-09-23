// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.21;

import "forge-std/Test.sol";
import "../src/1.sol";

contract HelloWeb3Test is Test {
    HelloWeb3 public helloWeb3;

    function setUp() public  {
        helloWeb3 = new HelloWeb3();
    }

    function test() public {
        assertEq(helloWeb3._string(),"hello Web3!");
    }
}
