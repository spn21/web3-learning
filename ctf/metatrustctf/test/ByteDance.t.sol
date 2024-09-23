pragma solidity ^0.8.0;

import {Test} from "../lib/forge-std/src/Test.sol";
import {ByteDance} from "../lib/ctf/byteDance/contracts/byteDance.sol";

contract ByteDanceTest is Test {
    ByteDance private deployer;
    address private solver;

    function setUp() external {
        deployer = new ByteDance();
        solver = address(new Solver());
    }

    function test_hackByteDance() external {
        deployer.checkCode(solver);
        assertTrue(deployer.isSolved());
    }
}

contract Solver {
    constructor() {
        bytes memory bytecode = hex"6101016111011B156101016111011B55610101611181F3";//61ffff61fffd5155
        assembly {
            return (add(bytecode, 0x20), mload(bytecode))
        }
    }
}
