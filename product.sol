// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract ProductInventory {
    // Mapping to track product stock by product name (as bytes32)
    mapping(bytes32 => uint) private _productStock;

    address public owner;

    // Events for logging product operations
    event ProductReceived(bytes32 indexed productName, uint quantity);
    event ProductSold(bytes32 indexed productName, uint quantity);

    // Constructor to set the owner at deployment
    constructor() {
        owner = msg.sender;
    }

    // Modifier to ensure only the owner can modify the stock
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action.");
        _;
    }

    // Function to receive new stock of a product
    function receiveProduct(string memory productName, uint quantity) public onlyOwner {
        require(quantity > 0, "Quantity must be greater than zero.");

        bytes32 productKey = keccak256(abi.encodePacked(productName));
        _productStock[productKey] += quantity;

        emit ProductReceived(productKey, quantity);
    }

    // Function to sell a product and reduce stock
    function sellProduct(string memory productName, uint quantity) public onlyOwner {
        bytes32 productKey = keccak256(abi.encodePacked(productName));
        require(_productStock[productKey] >= quantity, "Insufficient stock.");

        _productStock[productKey] -= quantity;

        emit ProductSold(productKey, quantity);
    }

    // Function to display the current stock of a product
    function displayStock(string memory productName) public view returns (uint) {
        bytes32 productKey = keccak256(abi.encodePacked(productName));
        return _productStock[productKey];
    }
}
