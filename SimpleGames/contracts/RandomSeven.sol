// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract RandomSeven {
  function random(uint x) public pure returns(string memory){
    uint N;
    uint MasRands;
    x = x * 1103515245 + 12345;
    N = (x/65536) % 32768;
    for (uint i = 1; i <= 5; i++){
      MasRands =(N % (10 ** i)) / (10 ** (i - 1));
      if(MasRands == 7) return ("Winner");
    }
    return ("Looser");
  }
}
