// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Gurl {
    address public owner;
    bytes32 private passphrase = keccak256(abi.encodePacked("warlocksmurf wants your ethereum")); 

    constructor() payable {
        owner = msg.sender;  
    }

    function withdraw() public {
        require(msg.sender == owner, "Not the owner");
        payable(msg.sender).transfer(address(this).balance);
    }

    function claim(bytes32 _secret) public payable {
        require(msg.value == 0.01 ether, "Must send 0.01 ETH");
        require(_secret == passphrase, "Incorrect passphrase");
        owner = msg.sender;
    }
}
