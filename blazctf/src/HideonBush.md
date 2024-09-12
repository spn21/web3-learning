目标；```weth.balanceOf(address(this)) > amount + claimableAmount / 3;```
    ```uint256 constant amount = 500 ether;```
    ```uint256 constant claimableAmount = 100 ether;```
还是一个mev bot题，但是自己之前做的很少，看了很久

空投那部分好找，在
```require(keccak256(abi.encodePacked(password)) == keccak256("m3f80"))```这里
密码是m3f80

mev bot这会抢跑交易，看了wp才知道用蜜罐原来能直接解决

//今天身体状态不好，头一直晕，难受得想吐