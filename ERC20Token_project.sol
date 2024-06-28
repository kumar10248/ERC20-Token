// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20Token is ERC20 {

    address private contractOwner;
    uint256 public pointsPerTransaction;

    modifier onlyOwner() {
        require(msg.sender == contractOwner, "you are not the owner");
        _;
    }

    constructor(uint256 initialSupply, uint256 _pointsPerTransaction) ERC20("LoyaltyToken", "LTY") {
        _mint(msg.sender, initialSupply);
        contractOwner = msg.sender;
        pointsPerTransaction = _pointsPerTransaction;
    }

    function earnPoints(address customer, uint256 transactionAmount) external onlyOwner {
        uint256 points = (transactionAmount / 1 ether) * pointsPerTransaction;
        _mint(customer, points);
    }

    function redeemPoints(address customer, uint256 points) external onlyOwner {
        _burn(customer, points);
    }

    function updatePointsRate(uint256 newRate) external onlyOwner {
        pointsPerTransaction = newRate;
    }
}
