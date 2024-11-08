// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;

import "./TimeLock.sol";

contract Setup {
    TimeLock public challengeInstance;

    constructor() payable {
        
        challengeInstance = new TimeLock{value: 3 ether}();

    }

    // Function to check if the challenge is solved
    function isSolved() public view returns (bool) {
        
        return address(challengeInstance).balance == 0;
    }
}
