//SPDX-License-Identifier: MIT

contract DataStorage {
        uint[] public x =[1,2,3];

    function fStorage() public {
        uint[] storage xStorage = x;
        xStorage[0] =100;
    }

    function fMemory() public view {
        uint[] memory xMemory = x;
        xMemory[0] =100;
        xMemory[1] =200;
        uint[] memory xMemory2 = x;
        xMemory2[0] =300;
    }

    function fCalldata(uint[] calldata _x) public pure returns(uint[] calldata) {
        return(_x);
    }
}

contract Variable {
    uint public x = 1;
    uint public y;
    string public z;

    function foo() external {
        x =5;
        y =2;
        z ="spn";
    }

    function bar() external pure returns(uint) {
        uint xx =5;
        uint yy =2;
        uint zz =xx + yy;
        return(zz);
    }

    function global() external view returns(address,uint,bytes memory) {
        address sender = msg.sender;
        uint blockNum = block.number;
        bytes memory data = msg.data;
        return(sender,blockNum,data);        
    }

    function weiUnit() external pure returns(uint) {
        assert(1 ether == 1e18);   
        assert(1 ether == 1000000000000000000);
        return 1 ether;
    }

    function secondsUinit() external pure returns(uint) {
        assert(1 seconds == 1);
        return 1 seconds;
    }

    function minitesUInt() external pure returns(uint) {
        assert(1 minutes == 60);
        assert(1 minutes == 60 seconds);
        return 1 minutes;
    }

    function hoursUnit() external pure returns(uint) {
        assert(1 hours == 3600);
        assert(1 hours == 60 minutes);
        return 1 hours; 
    }

    function dayUnit() external pure returns(uint) {
        assert(1 days == 86400);
        assert(1 hours == 60 minutes);
        return 1 hours;
    }

    function weekUnit() external pure returns(uint) {
        assert(1 weeks == 604800);
        assert(1 weeks == 7 days);
        return 1 weeks;
    }
}