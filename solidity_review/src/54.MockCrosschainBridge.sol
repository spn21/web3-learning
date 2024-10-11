// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface ICrosschainReceiver {
    function receiveMessage(uint256 sourceChainId, address sourceContract, bytes memory message) external;
}

contract MockCrosschainBridge {
    function sendMessage(uint256 targetChainId, address targetContract, bytes memory message) external {
        // 在实际的跨链桥中，这里会触发跨链消息的发送
        // 在这个模拟中，直接调用目标合约的 receiveMessage 函数
        ICrosschainReceiver(targetContract).receiveMessage(block.chainid, msg.sender, message);
    }

    function receiveMessage(uint256 sourceChainId, address sourceContract, bytes memory message) external {
        /* 这个函数在实际的跨链桥中会被用来接收来自其他链的消息
        在这个模拟中，不做任何事情
        */
    }
}