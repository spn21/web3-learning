// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.21;

contract ECDSAExample {
    function recoverSigner(bytes32 messageHash, uint8 v, bytes32 r, bytes32 s) public pure returns (address) {
        bytes memory prefix = "\x19 Signed Message: \n32";
        bytes32 prefixHash = keccak256(abi.encodePacked(prefix, messageHash));

        return ecrecover(prefixHash, v, r, s);
    }
    
    function isValidSignature(address signer, bytes32 messageHash, uint8 v, bytes32 r, bytes32 s) public pure returns(bool) {
        return signer == recoverSigner(messageHash, v, r, s);
    }

    function getMessageHash(string memory message) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(message));
    }

    function getEthSignedMessageHsh(bytes32 messageHash) public pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19 Signed Message:\n32", messageHash));
    }
}