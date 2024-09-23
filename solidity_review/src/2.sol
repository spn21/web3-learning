pragma solidity ^0.8.21;

contract ValueTypes{

bool public _bool = true;
bool public _bool1 = !_bool;
bool public _bool2 = _bool && _bool1;
bool public _bool3 = _bool1 || _bool;
bool public _bool4 = _bool == _bool1;
bool public _bool5 = _bool != _bool1;

uint256 public _number = 1;
uint256 public _number1 = _number + 1;
uint256 public _number2 = 2**2;
uint256 public _number3 = 7%2;
bool public_numberbool = _number2 > _number3;

address public _address=0x003A594540b8a29A74773E29A71E51fE448dfD89;
address payable public _address1 = payable(_address);
uint256 public balance = _address1.balance;

bytes32 public _bytes32 = "test";
bytes1 public _byte = _bytes32[0];


enum ActionSet { Buy, Hold, Sell}

ActionSet action = ActionSet.Buy;
function enumToUint() external view returns(uint) {
    return uint(action);
}
}