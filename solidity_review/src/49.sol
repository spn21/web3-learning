// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.21;

contract UUPSProxy {
    address public implementation;
    address public admin;
    string public words;

    constructor (address _implemenation) {
        admin = msg.sender;
        implementation = _implemenation;

    }
        fallback() external payable {
            (bool success, bytes memory data) = implementation.delegatecall(msg.data);
        }
    }

    contract UUPS1 {
        address public implementation;
        address public admin;
        string public words;

        function foo() public {
            words = "old";
        }

        function upgrade( address newImplementation) external {
            require(msg.sender == admin);
            implementation = newImplementation;
        }
    }

    contract UUPS2 {
        address public implementation;
        address public admin;
        string public words;

    function foo() public {
        words = "new";
    }

    function upgrade(address newImplementation) external {
        require(msg.sender == admin);
        implementation = newImplementation;
    }
}
