// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../lib/forge-std/src/Test.sol";
import "../../lib/blazctf-2023/challenges/lockless-swap/challenge/project/src/Challenge.sol";
import "./lockless-swapAttack.sol";

contract ReentrancyAttackTest is Test {
    Challenge public challenge;
    PancakePair public pair;
    ReentrancyAttack public attack;

    function setUp() public {

        challenge = new Challenge(address(0));
        
        pair = challenge.pair();
        
        attack = new ReentrancyAttack(address(challenge), address(pair));
    }

       function testReentrancyAttack() public {
        uint256 initialToken0Balance = challenge.token0().balanceOf(address(attack));
        uint256 initialToken1Balance = challenge.token1().balanceOf(address(attack));
        
        attack.startAttack();
        
        uint256 finalToken0Balance = challenge.token0().balanceOf(address(attack));
        uint256 finalToken1Balance = challenge.token1().balanceOf(address(attack));
        
        assertGt(finalToken0Balance, initialToken0Balance, "Token0 balance did not increase after attack");
        assertGt(finalToken1Balance, initialToken1Balance, "Token1 balance did not increase after attack");

        bool isSolved = challenge.isSolved();
        assertTrue(isSolved, "Challenge is not solved");
    }
}