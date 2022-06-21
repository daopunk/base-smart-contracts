// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract SplitPay {
  uint256 public deposit;
  address payable[] members;

	constructor(uint256 amount) {
      deposit = amount;
  }

  mapping(address => bool) public paid;

  function rsvp() payable external {
    require(msg.value == deposit);
    require(!paid[msg.sender]);
    paid[msg.sender] = true;
    members.push(payable(msg.sender));
  }

  function payBill(address payable venue, uint256 amount) external {
    require(address(this).balance >= amount);
    venue.transfer(amount);
    uint256 payout = address(this).balance / members.length;
    for (uint i=0; i<members.length; i++) {
      members[i].transfer(payout);
    }
  }
}