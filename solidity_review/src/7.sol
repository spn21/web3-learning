pragma solidity ^0.8.21;

contract Mapping {
    mapping(uint => address) public idToAddress;
    mapping(address => uint) public swapPair;

    function writeMap (uint _Key,address _Value) public {
        idToAddress[_Key] = _Value;
    }
}