// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProductInventory {
    // Struct to store product details
    struct Product {
        string name;
        uint quantity;
        uint price;
    }
    
    // Mapping to store each product by its ID
    mapping(uint => Product) private products;
    uint private productCount;

    address public owner;

    // Events to log product additions and sales
    event ProductReceived(uint productId, string name, uint quantity);
    event ProductSold(uint productId, string name, uint quantitySold);

    // Modifier to restrict certain functions to only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action.");
        _;
    }

    // Constructor to set the owner of the contract
    constructor() {
        owner = msg.sender;
    }

    // Function to add a new product to the inventory
    function receiveProduct(string memory name, uint quantity, uint price) public onlyOwner {
        require(quantity > 0, "Quantity must be greater than zero.");
        require(price > 0, "Price must be greater than zero.");

        productCount++;
        products[productCount] = Product(name, quantity, price);

        emit ProductReceived(productCount, name, quantity);
    }

    // Function to sell a product
    function saleProduct(uint productId, uint quantity) public {
        require(products[productId].quantity >= quantity, "Not enough stock available.");
        require(quantity > 0, "Quantity must be greater than zero.");

        products[productId].quantity -= quantity;

        emit ProductSold(productId, products[productId].name, quantity);
    }

    // Function to view the current stock of a product
    function displayStock(uint productId) public view returns (string memory name, uint quantity, uint price) {
        require(productId > 0 && productId <= productCount, "Invalid product ID.");
        
        Product memory product = products[productId];
        return (product.name, product.quantity, product.price);
    }

    // Function to view the total number of products
    function totalProducts() public view returns (uint) {
        return productCount;
    }
}
