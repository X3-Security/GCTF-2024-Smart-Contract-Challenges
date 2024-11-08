// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Cake {
    address public owner;
    uint256 private secretPassword; //Private variables are still public on the blockchain. this value can be retrieved using foundry cast commands
    uint256 public bonusCounter; 
    uint256 public ownerRewardPoints; 
    
    constructor(uint256 _password) {
        owner = msg.sender;
        secretPassword = _password;
        bonusCounter = 0;
        ownerRewardPoints = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    
    function changeOwner(uint256 _password, address _newOwner) public { //use the secretPassword retrieved with cast in this function and change the owner
        require(_password == secretPassword, "Incorrect password");
        owner = _newOwner;
    }

    
    function checkBonusCode(uint256 _bonusCode) public returns (bool) { //redundant function can ignore
        if (_bonusCode == 888888) {
            bonusCounter++;
            return true; // Correct bonus code entered
        } else {
            return false; // Invalid bonus code
        }
    }

    
    function generateRandomNumber() public view returns (uint256) { //redundant function can ignore
        
        return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 100;
    }

    
    function ownerCollectReward() public onlyOwner {
        ownerRewardPoints++; 
    }
}
