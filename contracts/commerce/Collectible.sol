// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Collectible {
  address payable owner;
  uint public price;

  constructor () {
    owner = payable(msg.sender);
    emit Deployed(owner);
  }

  event Deployed(address indexed owner);
  event Transfer(address indexed from, address indexed to);
  event ForSale(uint price, uint blockTime);
  event Purchase(uint amount, address indexed buyer);

  function transfer(address payable _to) external {
    require(msg.sender == owner);
    owner = _to;
    emit Transfer(msg.sender, owner);
  }

  function markPrice(uint _price) external {
    require(msg.sender == owner);
    price = _price;
    emit ForSale(price, block.timestamp);
  }

  function purchase() payable public {
    require(price > 0);
    require(msg.value == price);
    price = 0;
    owner.transfer(msg.value);
    owner = payable(msg.sender);
    emit Purchase(msg.value, msg.sender);
  }
}