// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CustomerData {
    // Structure to store customer details
    struct Customer {
        uint id;
        string name;
        string email;
        uint balance;
    }

    // Array to store multiple customer records
    Customer[] public customers;

    // Address of the contract owner
    address public owner;

    // Event to log when Ether is received
    event EtherReceived(address sender, uint amount);

    // Constructor to set the contract owner
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can add customers.");
        _;
    }

    // Fallback function to accept ether sent directly to the contract
    fallback() external payable {
        // Emit an event when Ether is received
        emit EtherReceived(msg.sender, msg.value);
    }

    // Receive function to accept ether (alternative to fallback function)
    receive() external payable {
        // Emit an event when Ether is received
        emit EtherReceived(msg.sender, msg.value);
    }

    // Function to add a new customer
    function addCustomer(uint _id, string memory _name, string memory _email, uint _balance) public onlyOwner {
        customers.push(Customer(_id, _name, _email, _balance));
    }

    // Function to get details of a customer by index
    function getCustomer(uint index) public view returns (uint, string memory, string memory, uint) {
        require(index < customers.length, "Invalid index.");
        Customer memory cust = customers[index];
        return (cust.id, cust.name, cust.email, cust.balance);
    }

    // Function to get the total number of customers
    function getTotalCustomers() public view returns (uint total) {
        return customers.length;
    }
}
