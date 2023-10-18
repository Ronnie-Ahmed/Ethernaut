// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Privacy {
    // Every slot take 32 bytes;
    //bool take 1 byte slot 0
    bool public locked = true;
    //uint256 take 32 bytes slot 1
    uint256 public ID = block.timestamp;
    //uint8 take 1 bytes slot 2
    uint8 private flattening = 10;
    //slot 2
    uint8 private denomination = 255;
    //uint16 take 2bytes slot 2
    uint16 private awkwardness = uint16(block.timestamp);
    //bytes32 take 32 bytes slot 3 data[0], slot 4 data[1], slot 5 data[2]
    bytes32[3] private data;

    constructor(bytes32[3] memory _data) {
        data = _data;
    }

    //await web3.eth.getStorageAt(contract.address,5)
    // return bytes32 of private data[2]
    // convert it to bytes16 done
    function unlock(bytes16 _key) public {
        require(_key == bytes16(data[2]));
        locked = false;
    }

    /*
    A bunch of super advanced solidity algorithms...

      ,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`
      .,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,
      *.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^         ,---/V\
      `*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.    ~|__(o.o)
      ^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'  UU  UU
  */
}

contract Hack {
    function convert(bytes32 temp) public pure returns (bytes16) {
        return bytes16(temp);
    }
}
