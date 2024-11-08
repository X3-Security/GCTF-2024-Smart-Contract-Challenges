// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;

contract TimeLock {
    uint256 public lockTime;
    uint256 public contractBalance;

    constructor() payable {
        //require(msg.value == 3 ether, "Contract requires exactly 3 ETH");
        contractBalance = msg.value;
        lockTime = block.timestamp + (10 * 365 * 24 * 60 * 60); // Initial lock time of 10 years
    }

    
    function increaseLockTime(uint256 _secondsToIncrease) public {
        lockTime += _secondsToIncrease;
    }

    // Function to withdraw all the funds, requires the lock time to have passed
    function withdraw() public {
        require(block.timestamp > lockTime, "Funds are locked");
        require(contractBalance > 0, "No funds to withdraw");

        uint256 amount = contractBalance;
        contractBalance = 0;

        
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
    }

}
