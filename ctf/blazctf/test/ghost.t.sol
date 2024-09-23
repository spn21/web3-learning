// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../lib/forge-std/Test.sol";

contract ChallengeTest is Test {
    // Challenge contract instance
    Challenge challenge;

    // Initialize before each test
    function setUp() public {
        challenge = new Challenge(address(this));
    }

    function testMEMOperations() public {
        // Initialize MEM array as uint256
        uint256[515] memory MEM;

        // Instructions as per the Python code
        uint256[39] memory instructions = [
            2, 2, 0, 1,
            0, 1,
            2, 2, 0, 1,
            2, 2, 0, 1,
            2, 2, 0, 1,
            2, 2, 0, 1,
            2, 2, 0, 1,
            2, 2, 0, 1,
            2, 2, 0, 1,
            2, 0, 1,
            2, 2, 0, 1,
            2, 2, 0, 1,
            2, 2, 0, 1
        ];

        // Padding instructions with 181 `2`s and 9 `1`s
        for (uint i = 0; i < 181; i++) {
            instructions[i + 39] = 2;
        }
        for (uint i = 0; i < 9; i++) {
            instructions[i + 220] = 1;
        }

        // Loading initial MEM array from instructions
        for (uint i = 0; i < instructions.length; i++) {
            MEM[2 + i] = instructions[i];
        }

        // Main loop to modify MEM[514] based on the values in MEM[2+i]
        for (uint i = 0; i < 256; i++) {
            if (MEM[2 + i] == 0) {
                MEM[514] += 3;
            } else if (MEM[2 + i] == 1) {
                MEM[514] -= 2;
            } else if (MEM[2 + i] == 2) {
                MEM[258 + MEM[514]] += 1;
            }
        }

        // Check final values
        assertEq(MEM[514], 0);

        // Now handle new instructions
        uint256[17] memory newInstructions = [
            2, 0, 2, 2, 2, 2, 2, 2, 2, 1,
            2, 2, 2, 0, 1, 2, 2
        ];

        // Overwrite memory starting from 258 with newInstructions
        for (uint i = 0; i < newInstructions.length; i++) {
            MEM[258 + i] = newInstructions[i];
        }

        // Validate
        for (uint i = 0; i < 128; i++) {
            if (MEM[258 + i] == 0) {
                MEM[514] += 3;
            } else if (MEM[258 + i] == 1) {
                MEM[514] -= 2;
            } else if (MEM[258 + i] == 2) {
                MEM[386 + MEM[514]] += 1;
            }
        }

        // Final assertions to match Python
        assertEq(MEM[386], 1);
        assertEq(MEM[387], 3);
        assertEq(MEM[388], 3);
        assertEq(MEM[389], 7);
    }
}