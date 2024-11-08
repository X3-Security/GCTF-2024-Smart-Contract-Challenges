// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./FaultyTokenOwner.sol";

contract Setup {
    FaultyTokenOwner public token;
    uint256 public targetMintAmount = 1_000_000 * 10 ** 18; // 1 million tokens

    constructor() {
        // Deploy the token contract
        token = new FaultyTokenOwner();
    }

    // Function to check if the challenge is solved
    function isSolved(address user) public view returns (bool) {
        
        return token.balanceOf(user) >= targetMintAmount;
    }
}
