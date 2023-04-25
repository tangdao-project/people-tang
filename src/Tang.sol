// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC721} from "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";
import {Counters} from "openzeppelin-contracts/contracts/utils/Counters.sol";
import {Strings} from "openzeppelin-contracts/contracts/utils/Strings.sol";

contract Tang is ERC721, Ownable {
    event BatchMetadataUpdate(uint256 _fromTokenId, uint256 _toTokenId);

    using Counters for Counters.Counter;
    using Strings for uint256;

    Counters.Counter private tokenId;

    string public baseURI;

    constructor() ERC721("People Tang", "TANG") {}

    function mint() public {
        _mint(msg.sender, tokenId.current());
        tokenId.increment();
    }

    function tokenURI(uint256 id) public view override returns (string memory) {
        _requireMinted(id);

        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, id.toString(), ".json")) : "";
    }

    function setBaseURI(string memory _uri) public onlyOwner {
        baseURI = _uri;

        emit BatchMetadataUpdate(0, tokenId.current());
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }
}
