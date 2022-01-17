// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract Transaction {
 address public owner;
 mapping (address => uint) public balances;
 event Send(address from,address to,uint amount);

 constructor() {
   owner = msg.sender;
 }

 function coin(address receiver,uint amount)public {
   require (msg.sender == owner, "only Owner");
   require (amount < 1e60, "To much amount");
   balances[receiver]  += amount;
 }

 function send(address receiver, uint amount) public {
   require (amount <= balances[msg.sender], "Not money");
   balances[msg.sender] -= amount;
   balances[receiver] += amount;
   emit Send(msg.sender, receiver, amount);
 }
}
