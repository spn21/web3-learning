/*
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.2;
pragma experimental ABIEncoderV2;

import {Test} from "../lib/forge-std/src/Test.sol";
import {BytecodeVault} from "../lib/ctf/byteVault/contracts/bytecodeVault.sol";

contract BytecodeVaultTest is Test {
    BytecodeVault public vault;
    Solver public solver;

    function setUp()  external {
        vault = new BytecodeVault{value: 1}();
        solver = new Solver();

        assertTrue(vault.isSolved());
    }

    function test_hackBytecodeVault() external {
        solver.solve(vault);
        assertTrue(vault.isSolved());
    }
}

contract Solver {
    receive() external payable {}
    bytes constant t1 = "0xdeadbeef";
    bytes constant t2 = hex"deadbeef";

    function attack(BytecodeVault addr) public {
        bytes memory h1 = t1;
        bytes memory h2 = t2;

        addr.withdraw();
}
}
*/