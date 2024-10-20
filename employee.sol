// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EmployeeData {
    // Employee structure to store details
    struct Employee {
        uint id;
        string name;
        string position;
        uint salary;
    }

    // Array to store multiple Employee records
    Employee[] public employees;

    address public owner;

    // Constructor to set contract owner
    constructor() {
        owner = msg.sender;
    }

    // Modifier to allow only the owner to modify data
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can add employees.");
        _;
    }

    // Fallback function to handle ether sent directly to the contract
    fallback() external payable {}

    // Receive function to accept ether (alternative to fallback)
    receive() external payable {}

    // Function to add a new employee
    function addEmployee(uint _id, string memory _name, string memory _position, uint _salary) public onlyOwner {
        employees.push(Employee(_id, _name, _position, _salary));
    }

    // Function to retrieve details of an employee by index
    function getEmployee(uint index) public view returns (uint id , string memory name, string memory position, uint balance) {
        require(index < employees.length, "Invalid index.");
        Employee memory emp = employees[index];
        return (emp.id, emp.name, emp.position, emp.salary);
    }

    // Function to get the total number of employees
    function getTotalEmployees() public view returns (uint) {
        return employees.length;
    }
}
