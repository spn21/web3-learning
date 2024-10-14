// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract ECDSAExample {
    function recoverSigner(bytes32 messageHash, uint8 v, bytes32 r, bytes32 s) public pure returns (address) {
        bytes memory prefix = "\x19Ethereum Signed Message:\n32";
        bytes32 prefixedHash = keccak256(abi.encodePacked(prefix, messageHash));
        
        return ecrecover(prefixedHash, v, r, s);
    }

    function isValidSignature(address signer, bytes32 messageHash, uint8 v, bytes32 r, bytes32 s) public pure returns (bool) {
        return signer == recoverSigner(messageHash, v, r, s);
    }

    function getMessageHash(string memory message) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(message));
    }

    function getEthSignedMessageHash(bytes32 messageHash) public pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", messageHash));
    }
}

contract ECDSATest is Test {
    ECDSAExample public ecdsa;
    uint256 private signerPrivateKey;
    address public signerAddress;

    function setUp() public {
        ecdsa = new ECDSAExample();
        signerPrivateKey = 0xA11CE;  // 测试私钥
        signerAddress = vm.addr(signerPrivateKey);
    }

    function testMessageHashing() public {
        string memory message = "Hello, ECDSA!";
        bytes32 messageHash = ecdsa.getMessageHash(message);
        bytes32 ethSignedMessageHash = ecdsa.getEthSignedMessageHash(messageHash);

        assertEq(messageHash, keccak256(abi.encodePacked(message)), "Message hash should match");
        assertEq(ethSignedMessageHash, keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", messageHash)), "Ethereum signed message hash should match");
    }

    function testValidSignature() public {
        string memory message = "Hello, ECDSA!";
        bytes32 messageHash = ecdsa.getMessageHash(message);
        bytes32 ethSignedMessageHash = ecdsa.getEthSignedMessageHash(messageHash);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerPrivateKey, ethSignedMessageHash);

        bool isValid = ecdsa.isValidSignature(signerAddress, messageHash, v, r, s);
        assertTrue(isValid, "Signature should be valid");
    }

    function testInvalidSignature() public {
        string memory message = "Hello, ECDSA!";
        bytes32 messageHash = ecdsa.getMessageHash(message);
        bytes32 ethSignedMessageHash = ecdsa.getEthSignedMessageHash(messageHash);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerPrivateKey, ethSignedMessageHash);

        // 使用不同的消息哈希来测试无效签名
        bytes32 differentMessageHash = ecdsa.getMessageHash("Different message");
        bool isValid = ecdsa.isValidSignature(signerAddress, differentMessageHash, v, r, s);
        assertFalse(isValid, "Signature should be invalid for different message");
    }

    function testRecoverSigner() public {
        string memory message = "Hello, ECDSA!";
        bytes32 messageHash = ecdsa.getMessageHash(message);
        bytes32 ethSignedMessageHash = ecdsa.getEthSignedMessageHash(messageHash);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerPrivateKey, ethSignedMessageHash);

        address recoveredSigner = ecdsa.recoverSigner(messageHash, v, r, s);
        assertEq(recoveredSigner, signerAddress, "Recovered signer should match original signer");
    }
}