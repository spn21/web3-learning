pragma solidity ^0.8.21;
contract Events {
    mapping(address => uint256) public _balances;

    event Transfer(address indexed from, address indexed to,uint256 value);
    //event中不带indexed等参数会被存储在data部分中，不能被直接检索，但可以存储任意大小等数组
    function _transfer(
        address from,
        address to,
        uint256 amount
    )external {
        _balances[from] = 10000000;
        _balances[from] -= amount;
        _balances[to] += amount;

        emit Transfer(from,to,amount);
    }
}