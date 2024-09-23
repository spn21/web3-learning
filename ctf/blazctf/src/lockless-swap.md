faucet 函数允许任何人调用，并接收1单位的token0和token1。尽管数量较小，但如果有人可以无限次调用这个函数，那么可能导致合约中的代币被耗尽，而且faucet函数和其他与外部合约交互的函数没有防止重入攻击，
```
The challenge uses a PancakePair without reentrancy guard. You can swap and reenter to mint to drain fund.
```