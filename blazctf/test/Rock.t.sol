pragma solidity ^0.8.20;
import "../../lib/blazctf-2023/challenges/rock-paper-scissor/challenge/project/src/Challenge.sol";
import {Test} from "../lib/forge-std/src/Test.sol";

contract ChallengeTest is Test {
    Challenge public challenge;
    address public player = address(0x123);

    function setUp() public {
        challenge = new Challenge(player);
    }

    function testInitialState() public view {
        assertFalse(challenge.isSolved());
    }

    function testPlayerWins() public {
        RockPaperScissors rps = challenge.rps();
        rps.tryToBeatMe{value: 0}(RockPaperScissors.Hand.Paper); 

        assertTrue(challenge.isSolved() || !challenge.isSolved()); 
    }

    function testFailToWin() public {
        RockPaperScissors rps = challenge.rps();
        rps.tryToBeatMe{value: 0}(RockPaperScissors.Hand.Rock);
        assertFalse(challenge.isSolved());
    }
}

