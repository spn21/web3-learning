// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "../lib/forge-std/src/Test.sol";
import {Gate} from "../lib/ctf/greeterGate/contracts/greeterGate.sol";

contract GreeterGateTest is Test {
    Gate public gate;

    function setUp() external {
        bytes32 data1 = calcHash(block.timestamp);
        bytes32 data2 = calcHash(block.number);
        bytes32 data3 = calcHash(uint256(uint160(address(block.coinbase))));

        gate = new Gate(data1, data2, data3);
    }

    function test_hackGreeterGate() public {
        bytes32 codeLine = vm.load(address(gate), bytes32(uint256(5)));

        bytes memory bytesCode;
        assembly {
            mstore(bytesCode, 0x20)
            mstore(add(bytesCode, 0x20), codeLine)
        }

        bytes memory callData = abi.encodeCall(Gate.unlock, (bytesCode));
        gate.resolve(callData);
        assertTrue(gate.isSolved());
    }

    function calcHash(uint256 input) private pure returns (bytes32) {
        return keccak256(abi.encode(input));
    }
}