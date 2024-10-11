// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.21;

interface ICrosschainBridge {
    function sendMessage(uint256 targetChainId, address targetContract, bytes memory messgae) external ;
    function receiveMessage(uint256 sourceChainId, address sourceContract, bytes memory message) external;
   
}

contract CrosschainMessage {
    ICrosschainBridge public bridge;
    mapping(uint256 => string) public messages;
    uint256 public messageCount;

    event MessageSent(uint256 indexed targetChainId, string message);
    event MessageReceived(uint256 indexed sourceChainId, string message);

    constructor(address _bridge) {
        bridge = ICrosschainBridge(_bridge);
    }

    function sendMessage(uint256 targetChainId, string memory message) external {
        bytes memory encodedMessage = abi.encode(message);
        bridge.sendMessage(targetChainId, address(this), encodedMessage);
        emit MessageSent(targetChainId, message);
    }

    function receiveMessage(uint256 sourceChainId, address sourceContract, bytes memory encodeMessage) external {
        require(msg.sender == address(bridge), "Only bridge can call this function");

        string memory message = abi.decode(encodeMessage,(string));
        messageCount++;
        messages[messageCount] = message;

        emit MessageReceived(sourceChainId, message);
    }

    function getLatestMessage() external view returns(string memory) {
        require(messageCount > 0, "No message received yet");
        return messages[messageCount];
    }
}