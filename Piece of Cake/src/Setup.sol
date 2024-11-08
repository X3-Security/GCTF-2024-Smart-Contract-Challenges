// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Cake.sol"; // Import the Cake contract

contract Setup {
    Cake public cake; // Instance of the Cake contract

    constructor(uint256 _password) {
        // Deploy the Cake contract, with the Setup contract itself as the initial owner
        cake = new Cake(_password);
    }

    // Check if the challenge is solved (i.e., if msg.sender has become the owner of the Cake contract)
    function isSolved() public view returns (bool) {
        return cake.owner() == msg.sender; // Check if the player calling this function is the owner
    }
}
