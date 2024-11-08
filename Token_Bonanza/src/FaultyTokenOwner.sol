// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Minimal interface for ERC20 standard functions
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// Minimal ERC20 implementation
contract FaultyTokenOwner is IERC20 {
    string public name = "FaultyOwnerToken";
    string public symbol = "FOT";
    uint8 public decimals = 18;
    uint256 private _totalSupply;
    address public owner;
    uint256 public maxMintAmount = 10_000_000 * 10 ** 18; // 10 million FOT tokens in supply

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    // Modifier to check if the sender is not the owner (incorrect logic for the CTF)
    modifier onlyOwner() {
        require(msg.sender != owner, "!owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Function to mint tokens (exploit in the modifier)
    function mint(uint256 amount) public onlyOwner {
        require(_totalSupply + amount <= maxMintAmount, "Minting limit exceeded");
        _mint(msg.sender, amount);
    }

    // Function to check user balance
    function checkUserBalance() public view returns (bool) {
        require(_balances[msg.sender] > 0, "User has no balance");
        return true;
    }

    // Function to check contract balance
    function checkContractBalance() public view returns (bool) {
        require(address(this).balance > 0, "Contract has no balance");
        return true;
    }

    // Internal function to mint tokens
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    // ERC20 functions
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, _allowances[sender][msg.sender] - amount);
        return true;
    }

    // Internal functions for transfer and approval
    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _balances[sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    // Fallback to receive ETH
    receive() external payable {}
}
