头铁法：直接暴力枚举（x
正确解法：对```uint256(keccak256(abi.encodePacked(msg.sender, blockhash(block.number - 1)))) % 3```
获得对手到hash并计算正确策略