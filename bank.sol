// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract MyBank {
    mapping(address => uint) private _balances;

    address public owner;

    event LogDepositMade(address indexed accountHolder, uint amount);
    event LogWithdrawalMade(address indexed accountHolder, uint amount);

    // Mark the constructor as payable to receive Ether at deployment
    constructor() payable {
        owner = msg.sender;
        _balances[msg.sender] = msg.value;  // Store the initial Ether sent
        emit LogDepositMade(msg.sender, msg.value);
    }

    function deposit() public payable returns (uint) {
        require(msg.sender != address(0), "Invalid address.");
        require(msg.value > 0, "Deposit must be greater than zero.");

        _balances[msg.sender] += msg.value;
        emit LogDepositMade(msg.sender, msg.value);
        return _balances[msg.sender];
    }

    function withdraw(uint withdrawAmount) public returns (uint) {
        require(_balances[msg.sender] >= withdrawAmount, "Insufficient balance.");
        require(msg.sender != address(0), "Invalid address.");

        _balances[msg.sender] -= withdrawAmount;
        payable(msg.sender).transfer(withdrawAmount);  // Use payable for transfer
        emit LogWithdrawalMade(msg.sender, withdrawAmount);
        return _balances[msg.sender];
    }

    function viewBalance() public view returns (uint) {
        return _balances[msg.sender];
    }
}
