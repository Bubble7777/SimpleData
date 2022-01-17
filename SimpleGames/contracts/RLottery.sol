// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract RLottery {
   struct Player{
     uint num;
   }
   mapping(uint => Player) public playeres;

  function getTicket(uint Num)public payable{
    require(Num <= 10, 'Ten players already registered!');
    playeres[Num] = Player(Num);
  }

  function winner()public view returns(string memory, uint){
    uint length = 10;
    uint index;
    uint randomNumber = uint(keccak256(abi.encodePacked(block.timestamp,msg.sender, length))) % 9;
    randomNumber++;
    index = randomNumber % 10;
    return ("Winner number", index);
  }
}
