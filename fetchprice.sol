// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPriceFeed {
    function getTokenAPrice() external view returns (uint256);
    function getTokenBPrice() external view returns (uint256);
}

contract PriceFeed is IPriceFeed {
    // State variables to store prices
    uint256 private tokenAPrice;
    uint256 private tokenBPrice;

    // Event for price updates
    event PricesUpdated(uint256 tokenAPrice, uint256 tokenBPrice);

    // Constructor to initialize prices
    constructor(uint256 _tokenAPrice, uint256 _tokenBPrice) {
        tokenAPrice = _tokenAPrice;
        tokenBPrice = _tokenBPrice;
        emit PricesUpdated(_tokenAPrice, _tokenBPrice);
    }

    // Function to get the price of Token A
    function getTokenAPrice() external view override returns (uint256) {
        return tokenAPrice;
    }

    // Function to get the price of Token B
    function getTokenBPrice() external view override returns (uint256) {
        return tokenBPrice;
    }

    // Function to update prices (can be restricted to certain addresses if needed)
    function updatePrices(uint256 _tokenAPrice, uint256 _tokenBPrice) external {
        tokenAPrice = _tokenAPrice;
        tokenBPrice = _tokenBPrice;
        emit PricesUpdated(_tokenAPrice, _tokenBPrice);
    }
}
