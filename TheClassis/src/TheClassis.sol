// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TheClassis {
    mapping(address => uint256) public balances;
    
    // Allow users to bet by sending ETH to this contract
    function bet() public payable {
        require(msg.value > 0, "Must send some ETH to bet");
        balances[msg.sender] += msg.value;
    }

    //User able to witdraw te amount betted in the contract
    function withdraw() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balance to withdraw");

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        balances[msg.sender] = 0;
    }

    // View the contract balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // Fallback function to receive ETH
    receive() external payable {}
}
