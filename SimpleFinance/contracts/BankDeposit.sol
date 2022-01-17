// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import './SafeMath';

contract BankDeposit {
   using SafeMath for uint;
   mapping(address => uint) public userDeposit;
   mapping(address => uint) public balance;
   mapping(address => uint) public time;
   mapping(address => uint) public percentWithDraw;
   mapping(address => uint) public allPercentWithDraw;
   uint public stepTime = 0.05 hours;

   event Invest(address Investor, uint256 amount);
   event WithDraw(address Investor, uint256 amount);

   modifier userExist(){
     require(balance[msg.sender] > 0, 'Client not find');
     _;
   }

   modifier checkTime(){
     require(block.timestamp >= time[msg.sender].add(stepTime), "Not time for draw");
     _;
   }

   function bankAccount() public payable{
     require(msg.value >= .001 ether);
   }

   function collectPercent() userExist checkTime public{
     if((balance[msg.sender].mul(2)) <= allPercentWithDraw[msg.sender]){
       balance[msg.sender] = 0;
       time[msg.sender] = 0;
       percentWithDraw[msg.sender] = 0;
     }else{
       uint payout = payOutAmount();
       percentWithDraw[msg.sender] = percentWithDraw[msg.sender].add(payout);
       allPercentWithDraw[msg.sender] = allPercentWithDraw[msg.sender].add(payout);
       msg.sender.transfer(payout);
       emit WithDraw(msg.sender, payout);
     }
   }

   function deposit() public payable{
     if(msg.value > 0){
       if(balance[msg.sender] > 0 && block.timestamp > time[msg.sender].add(stepTime)){
         collectPercent();
         percentWithDraw[msg.sender] = 0;
       }
       balance[msg.sender] = balance[msg.sender].add(msg.value);
       time[msg.sender] = now;
       emit Invest(msg.sender, msg.value);
     }
   }

   function percentRate() public view returns(uint){
     if(balance[msg.sender] < 10 ether){
       return (5);
     }
     if(balance[msg.sender] >= 10 ether && balance[msg.sender] < 20 ether){
       return (7);
     }
     if(balance[msg.sendr] >= 20 && balance[msg.sendr] < 30 ether){
       return (8);
     }
     if(balance[msg.sender] >= 30 ether){
       return (9);
     }
   }

   function payOutAmount() public view returns(uint){
     uint percent = percentRate();
     uint different = block.timestamp.sub(time[msg.sender]).div(stepTime);
     uint rate = balance[msg.sender].div(100).mul(percent);
     uint withDrawAlAmount = rate.mul.(different).sub(percentWithDraw[msg.sender]);
     return withDrawAlAmount;
   }

   function returnDeposit() public {
     uint withDrawAlAmount = balance[msg.sender];
     balance[msg.sender] = 0;
     time[msg.sender] = 0;
     percentWithDraw[msg.sender] = 0;
     msg.sender.transfer(withDrawAlAmount);
   }


}
