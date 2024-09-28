pragma solidity ^0.8.21;

error TransferNotOwner();

    contract Errors {
        mapping(uint256 => address) private _owners;

        function TransferNotOwner1(uint256 tokenId, address newOwner) public {
            if (_owners[tokenId] != msg.sender) {
                revert TransferNotOwner();
            }

            _owners[tokenId] = newOwner;
        }

        function TransferNotOwner2(uint256 tokenId, address newOwner) public {
            require(_owners[tokenId] == msg.sender,"False");
            _owners[tokenId] = newOwner;
        }
        function TransferNotOwner3(uint256 tokenId, address newOwner) public {
            assert(_owners[tokenId] == msg.sender);
            _owners[tokenId] = newOwner;
        }
    }
