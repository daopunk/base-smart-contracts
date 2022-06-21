// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Hero {
  bool public alerted;
  Ambush public ambush;
  uint lastContact;

  struct Ambush {
    bool alerted;
    uint enemies;
    bool armed;
  }

  function alertBasic() external {
    alerted = true;
  }

  function alert(uint enemies, bool armed) external {
      ambush = Ambush(true, enemies, armed);
  }

  fallback() external {
    lastContact = block.timestamp;
  }
}