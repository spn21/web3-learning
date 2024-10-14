// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract ContractC {
    uint public num;
    address public sender;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
    }
}

contract ContractB {
    uint public num;
    address public sender;

    function callSetVars(address _addr, uint _num) external payable {
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
        require(success, "Call failed");
    }

    function delegatecallSetVars(address _addr, uint _num) external payable {
        (bool success, bytes memory data) = _addr.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
        require(success, "Delegatecall failed");
    }
}

contract ContractTest is Test {
    ContractC public c;
    ContractB public b;
    address public owner;

    function setUp() public {
        owner = address(this);
        c = new ContractC();
        b = new ContractB();
    }

    function testCallSetVars() public {
        uint testNum = 42;
        b.callSetVars(address(c), testNum);

        assertEq(c.num(), testNum, "C.num should be set to testNum");
        assertEq(c.sender(), address(b), "C.sender should be set to address of B");
        assertEq(b.num(), 0, "B.num should remain 0");
        assertEq(b.sender(), address(0), "B.sender should remain address(0)");
    }

    function testDelegatecallSetVars() public {
        uint testNum = 24;
        b.delegatecallSetVars(address(c), testNum);

        assertEq(b.num(), testNum, "B.num should be set to testNum");
        assertEq(b.sender(), owner, "B.sender should be set to the test contract address");
        assertEq(c.num(), 0, "C.num should remain 0");
        assertEq(c.sender(), address(0), "C.sender should remain address(0)");
    }
}