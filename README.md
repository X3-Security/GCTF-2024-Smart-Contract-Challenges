---

# 🌟 GCTF (Girls in CTF) 2024 Blockchain Challenges 🌟

Welcome to the public release of the blockchain challenges from the **GCTF (Girls in CTF) 2024 24-hour CTF competition** held on **October 12th** exclusively for women! These challenges provide hands-on experience with essential smart contract vulnerabilities, showcasing X3 Security’s commitment to creating educational and engaging content.

## 🚀 Challenge Overview

Below is a list of the challenges, each with a brief description and objectives:

1. **🪙 Allowance**  
   *Created by: Warlocksmurf*  
   **Objective**: Understand and exploit vulnerabilities in ERC20 token allowance mechanisms.  
   **Note**: This challenge does not require Foundry for setup.

2. **🍰 Piece of Cake**  
   *Created by: X3 Security*  
   **Objective**: Extract a private variable and change the contract owner.  
   **Description**: Delve into storage accessibility and learn the risks of improper variable handling in smart contracts.  
   **Note**: This challenge does not require Foundry for setup.

3. **⏳ Timelock**  
   *Created by: X3 Security*  
   **Objective**: Bypass a timelock mechanism through an overflow exploit.  
   **Description**: Exploit arithmetic vulnerabilities to bypass time-based restrictions.  
   **Instructions**: This challenge includes an on-chain exploit script in Foundry (`.s.sol`). Instructions for running the exploit script are in the test file.

4. **🔄 TheClassis**  
   *Created by: X3 Security*  
   **Objective**: Perform a classic reentrancy attack.  
   **Description**: Learn how reentrancy vulnerabilities can be exploited to drain contract funds.  
   **Instructions**: Use Foundry to enter the folder, run `forge build`, and refer to the test file for local testing and exploitation instructions.

5. **🏆 TokenBonanza**  
   *Created by: X3 Security*  
   **Objective**: Bypass owner-only restrictions.  
   **Description**: Gain unauthorized access by bypassing the owner modifier, focusing on access control weaknesses.  
   **Instructions**: Use Foundry to enter the folder, run `forge build`, and follow instructions in the test file to run the local test script.


## ⚙️ Getting Started

To work with these challenges, ensure you have Foundry installed and follow these general setup steps:

1. **Initialize Foundry**  
   In each challenge folder, initialize a new Foundry project by running:
   ```bash
   forge init
   ```

2. **Build the Project**  
   After initializing, build the project with:
   ```bash
   forge build
   ```

3. **Run Tests and Exploits**  
   Each challenge includes a test file for local testing. **Timelock** also has an on-chain exploit script (`.s.sol`). Follow instructions within the test files to run the solve scripts and exploits.


## 📚 Educational Purpose

These challenges are ideal for blockchain security enthusiasts to learn and practice smart contract vulnerabilities, helping to raise awareness of critical security issues in decentralized applications.

## 💡 Additional Resources

- **Foundry**: [Foundry Documentation](https://book.getfoundry.sh/) for setup and commands.

## 🎉 Acknowledgments

A huge thank you to **Rehack** for organizing an amazing CTF and to all the **Overlords** for ensuring a smooth-sailing competition. We hope you enjoy exploring, learning, and hacking responsibly!

--- 
