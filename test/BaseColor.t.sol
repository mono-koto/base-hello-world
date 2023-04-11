// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/BaseColor.sol";

contract TestBaseColor is Test {
    BaseColor c;

    function setUp() public {
        c = new BaseColor();
    }

    function testBar() public {
        assertEq(uint256(1), uint256(1), "ok");
    }

    function testFoo(uint256 x) public {
        vm.assume(x < type(uint128).max);
        assertEq(x + x, x * 2);
    }

    function testTokenURI() public {
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
