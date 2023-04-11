// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {ERC721} from "solmate/tokens/ERC721.sol";
import {LibString} from "solmate/utils/LibString.sol";

contract BaseColor is ERC721 {
    using LibString for uint256;

    constructor() ERC721("BaseColor", "BC") {}

    function mint(address to, uint24 tokenId) external {
        require(tokenId <= type(uint24).max, "Invalid RGBA color");
        _mint(to, tokenId);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_ownerOf[tokenId] != address(0), "NOT_MINTED");
        return string(
            abi.encodePacked(
                "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1 1' style='background-color:",
                rgb(tokenId),
                "'></svg>"
            )
        );
    }

    function rgb(uint256 tokenId) public pure returns (string memory) {
        require(tokenId <= type(uint24).max, "Invalid RGBA color");
        uint8 r = uint8(tokenId >> 16);
        uint8 g = uint8(tokenId >> 8);
        uint8 b = uint8(tokenId);

        return string(
            abi.encodePacked("rgb(", uint256(r).toString(), ",", uint256(g).toString(), ",", uint256(b).toString(), ")")
        );
    }
}
