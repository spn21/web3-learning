// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

import {SECP256R1_Verify} from "../lib/ctf/ECDSA_Solidity/contracts/Verify.sol";

contract ECDSA_Test {

    function test_hackECDSA() external {
        SECP256R1_Verify checker = new SECP256R1_Verify(); 

        uint256 r = 63607537464833691735591749192264666949015507649778588617129415496363033470442;
        uint256 s = 81151975433876942679411788898193316173687189598528750465766591194135989506938;

        checker.solve(r, s);
        require(checker.isSolved(), "NOT SOLVED!"); 
    }
}