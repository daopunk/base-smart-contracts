// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./PrimeLib.sol";

contract PrimeGame {
  using Prime for uint;

  function isWinner() external view returns (bool c) {
    c = block.number.isPrime();
  }
}