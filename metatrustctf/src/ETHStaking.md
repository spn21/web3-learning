代码很多(不适合上课读bushi)
又是不懂内联汇编的一天（
读完了也不是很难(重点是连续读完),我们需要清空一个保险合约（Insurance），可以通过调用 requestCompensation 函数来实现。然而，要调用这个函数，首先需要在 protectedContracts 列表中注册，这需要调用 registerContract 函数。而这个函数包含一个检查：msg.sender 的字节码必须与 StakingPool 合约的字节码完全相同。正常思路的话为了从 Insurance 合约中提取资金，我们需要调用 endOperatorService 函数，该函数只能在合约处于 Validating 状态时被调用。要将合约转移到这个状态，必须先调用 createValidator 函数，然后再读下去没啥灵感，分析死了（

这里的话是通过构造函数中替换合约的字节码。"因为合约的最终字节码会在构造函数执行结束时隐式返回"。我们可以使用内联汇编来实现这一点。只需在构造函数中修改变量，并返回 StakingPool 的字节码。
skip(1145141) 用于将区块时间戳前进到一个大于 12 周的时间，以绕过时间检查
在构造函数中使用 mload 和 return 指令，返回与原始 StakingPool 相同的字节码，从而绕过字节码检查.
