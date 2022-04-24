// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Token is ERC721, Ownable {
    using Counters for Counters.Counter;
    uint256 constant public MAX_TOKENS = 8888;
    uint256 constant public TOKEN_COST = 0;
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Token", "TK") {}

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://";
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721)
        returns (string memory)
    {
        return string(abi.encodePacked(super.tokenURI(tokenId), ".json"));
    }

        
    // Additional functions

    function totalSupply() public view returns (uint256) {
        return _tokenIdCounter.current();
    }

    modifier costs(uint256 _cost) {
        require(msg.value >= _cost, "Insufficient funds.");
        _;
    }

    function mint() public payable costs(TOKEN_COST) {
        require(totalSupply() < MAX_TOKENS, "Minting limit reached.");
        address to = msg.sender;
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }
}