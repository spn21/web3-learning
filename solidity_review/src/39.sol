// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.21;

contract ECDSAVRF {
    struct VRFOutput {
        uint256 randomness;
        uint8 v;
        bytes32 r;
        bytes32 s;
    }

    function verifyVRF(
        address signer,
        bytes32 input,
        VRFOutput memory output
    ) public pure returns (bool) {
        bytes32 messageHash = keccak256(abi.encodePacked(input, output.randomness));
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);
        
        address recoveredSigner = ecrecover(ethSignedMessageHash, output.v, output.r, output.s);
        
        return recoveredSigner == signer;
    }

    // 这个函数在实际应用中应该在链下执行
    function computeRandomness(bytes32 input, uint256 privateKey) public pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input, privateKey)));
    }

    function extractRandomness(VRFOutput memory output) public pure returns (uint256) {
        return output.randomness;
    }

    function recoverSigner(bytes32 messageHash, uint8 v, bytes32 r, bytes32 s) public pure returns (address) {
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);
        return ecrecover(ethSignedMessageHash, v, r, s);
    }
    
    function isValidSignature(address signer, bytes32 messageHash, uint8 v, bytes32 r, bytes32 s) public pure returns(bool) {
        return signer == recoverSigner(messageHash, v, r, s);
    }

    function getMessageHash(string memory message) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(message));
    }

    function getEthSignedMessageHash(bytes32 messageHash) public pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", messageHash));
    }
}