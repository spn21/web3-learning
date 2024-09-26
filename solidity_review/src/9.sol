pragma solidity ^0.8.21;
contract Constant {
    uint256 public constant CONSTANT_NUM = 10;
    string public constant CONSTANT_STRING = "spn";
    bytes public constant CONSTANT_BTYES = "spn21";
    address public constant CONSTANT_ADDRESS = 0x0000000000000000000000000000000000000001;

    uint256 public immutable IMMUTABLE_NUM = 9999999999;
    address public immutable IMMUTABLE_ADDRESS;
    uint256 public immutable IMMUTABLE_BLOCK;
    uint256 public immutable IMMUTABLE_TEST;

    constructor() {
        IMMUTABLE_ADDRESS = address(this);
        IMMUTABLE_NUM = 114514;
        IMMUTABLE_TEST = test();
    }

    function test() public pure returns(uint256) {
        uint256 what = 0;
        return what;
    }
}