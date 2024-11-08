// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Gurl.sol";

contract Setup {
    Gurl public challengeInstance;

    constructor() payable {
        // Deploy the Gurl contract and fund it with 1 ETH
        challengeInstance = new Gurl{value: 1 ether}();
    }

    // Function to check if the challenge is solved
    function isSolved() public view returns (bool) {
        // The challenge is solved if the sender has become the owner of the Gurl contract
        return challengeInstance.owner() != address(this);
    }
}
