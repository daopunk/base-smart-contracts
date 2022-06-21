// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Token {
  uint public totalSupply;
  string public name = "die";
  string public symbol = "DIE";
  uint8 public decimals = 18;

  event Transfer(address s, address r, uint);

  constructor() {
    totalSupply = 1000 * (10**18);
    bal[msg.sender] = totalSupply;
  }

  mapping(address => uint) public bal;

  function balanceOf(address account) external view returns(uint b) {
    b = bal[account];
  }

  function transfer(address recipient, uint amount) public returns(bool b) {
    require(bal[msg.sender] >= amount, "insufficient funds");
    bal[recipient] += amount;
    bal[msg.sender] -= amount;
    emit Transfer(msg.sender, recipient, amount);
    b = true;
  }
}