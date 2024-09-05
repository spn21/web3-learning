目标是通过swap合约swap Achilles拿下100个WETH token

这里阿克琉斯之踵在 _airdrop函数里:
首先airdrop到对应的地址上，直接改地址到对应的number上进行空投，这里尝试一下vanishingAddress进行随机空投然后直接收集
注：根据出题人的exp应该是``` to = address(uint160((uint160(address(this)) | block.number) ^ (uint160(address(this)) ^ uint160(address(this)))));```
取amount = 0 计算出来的，应该是效率最高的
这里```  _balances[airdropAddress] = airdropAmount;```会直接设置为airdropAmount（同时这里有个for循环会检查airdropAmount的次数，所以也不能设置的太大）

Swap合约的仿照[UnisSwapV2](https://web3caff.com/zh/archives/97392)的写法，主动向池子发送token进行交换，这里swap函数中to地址调用pancakeCall使得我们可以从外调用这个函数，每次设置完余额需要调用sync函数来更新reserve变量。收集大量Achilles进行挤兑，然后就能换出来一半WETH了

