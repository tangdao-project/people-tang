// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Tang.sol";

contract TangTest is Test {
    Tang public tang;

    function setUp() public {
        tang = new Tang();
    }

    function test_Mint() public {
        tang.mint();
        assertEq(tang.balanceOf(address(this)), 1);
    }

    function test_SetBaseURI() public {
        tang.setBaseURI("ipfs://1111");
        assertEq(tang.baseURI(), "ipfs://1111");
    }

    function test_TokenURI() public {
        tang.setBaseURI("ipfs://1111/");
        tang.mint();
        assertEq(tang.tokenURI(0), "ipfs://1111/0.json");
    }
}
