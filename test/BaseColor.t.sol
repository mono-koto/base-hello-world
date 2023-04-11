// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/BaseColor.sol";

contract TestBaseColor is Test {
    BaseColor c;

    function setUp() public {
        c = new BaseColor();
    }

    function testMint(uint24 tokenId, uint24 tokenId2) public {
        vm.assume(tokenId != tokenId2);
        c.mint(address(this), tokenId);
        c.mint(address(this), tokenId2);
        assertEq(c.balanceOf(address(this)), 2);
        assertEq(c.ownerOf(tokenId), address(this));
        assertEq(c.ownerOf(tokenId2), address(this));
    }

    function testFoo(uint256 x) public {
        vm.assume(x < type(uint128).max);
        assertEq(x + x, x * 2);
    }

    function testTokenURI() public {
        c.mint(address(this), 0);
        c.mint(address(this), 1);
        c.mint(address(this), 255);
        c.mint(address(this), 65535);
        c.mint(address(this), 65536);
        c.mint(address(this), type(uint24).max);
        assertEq(
            c.tokenURI(0),
            "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1 1' style='background-color:rgb(0,0,0)'></svg>"
        );
        assertEq(
            c.tokenURI(1),
            "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1 1' style='background-color:rgb(0,0,1)'></svg>"
        );
        assertEq(
            c.tokenURI(255),
            "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1 1' style='background-color:rgb(0,0,255)'></svg>"
        );
        assertEq(
            c.tokenURI(65535),
            "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1 1' style='background-color:rgb(0,255,255)'></svg>"
        );
        assertEq(
            c.tokenURI(65536),
            "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1 1' style='background-color:rgb(1,0,0)'></svg>"
        );
        assertEq(
            c.tokenURI(type(uint24).max),
            "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1 1' style='background-color:rgb(255,255,255)'></svg>"
        );
    }

    function testFailTokenURI(uint256 tokenId) public {
        vm.assume(tokenId >= type(uint24).max);
        c.tokenURI(tokenId);
    }
}
