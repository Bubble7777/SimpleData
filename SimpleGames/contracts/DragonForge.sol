// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./DragonFarm.sol";
contract DragonForge is DragonFarm {
   function reforg(string memory name, uint id, uint food) public payable {
     require(msg.value > 0, "Pay for food");
     uint brains = uint(keccak256((abi.encode(food))));
     brains = brains % (10 ** 16);
     uint newDna = (id + brains) / 2;
     dragons.push(Dragon(id,name, newDna));
   }
}
