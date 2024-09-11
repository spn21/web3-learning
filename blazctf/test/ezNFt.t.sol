// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "../lib/forge-std/src/Test.sol";
import "../../lib/blazctf-2023/challenges/eazy-nft/challenge/project/src/Challenge.sol"; // 导入需要测试的合约;

contract MintTest is Test {
    ET public et; 
    address public player;

    function setUp() public {
        player = address(this); 
        et = new ET(player); 
    }

    function testMint20Tokens() public {
        for (uint256 i = 0; i < 10; i++) {
            address owner = et.ownerOf(i);
            assertEq(owner, address(uint160(i))); 
        }

        for (uint256 i = 10; i < 20; i++) {
            et.mint(player, i); 
        }

        for (uint256 i = 10; i < 20; i++) {
            address owner = et.ownerOf(i);
            assertEq(owner, player); 
        }
    }
}