// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./TheClassis.sol";

contract Setup {
    TheClassis public challenge;

    constructor() payable {
        require(msg.value == 10 ether, "Must send exactly 10 ETH to fund challenge");
        
        challenge = new TheClassis();
        
        (bool success, ) = address(challenge).call{value: 10 ether}("");
        require(success, "Funding the challenge failed");
    }

    
    function isSolved() public view returns (bool) {
        return address(challenge).balance == 0;
    }

    
    function getChallengeBalance() public view returns (uint256) {
        return address(challenge).balance;
    }
}
