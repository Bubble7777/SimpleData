// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract DragonFarm {
  event NewDragon(uint id, string name, uint dna);
  struct Dragon{
    uint id;
    string name;
    uint dna;
  }
  Dragon[] public dragons;
  mapping (uint => address) public dragonOwner;
  mapping (address => uint) ownerDragon;

  function generateRandomDna(string memory str) internal pure returns(uint){
    uint rand = uint(keccak256(abi.encode(str)));
    return rand % (10 ** 16);
  }

  

  function createDragon(string memory name) public {
    uint randDna = generateRandomDna(name);
    uint id = ownerDragon[msg.sender];
    dragons.push(Dragon(id, name, randDna));
    dragonOwner[id] = msg.sender;
    emit NewDragon(id,name,randDna);
    ownerDragon[msg.sender]++;
  }
}
