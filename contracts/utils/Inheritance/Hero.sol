// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface Enemy {
	function takeAttack(Hero.AttackTypes attackType) external;
}

contract Hero {
	uint public health;
	uint public energy = 10;
	constructor(uint _health) {
		health = _health;
	}

	enum AttackTypes { Brawl, Spell }
	function attack(address) public virtual {
		energy--;
	}
}

contract Mage is Hero(50) {
  function attack(address addr) public override {
    Enemy enemy = Enemy(addr);
    enemy.takeAttack(Hero.AttackTypes.Spell);
    Hero.energy--;
  }
}

contract Warrior is Hero(200) {
  function attack(address addr) public override {
    Enemy enemy = Enemy(addr);
    enemy.takeAttack(Hero.AttackTypes.Brawl);
    Hero.energy--;
  }
}