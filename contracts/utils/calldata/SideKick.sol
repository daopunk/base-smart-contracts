// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IHero {
  function alertBasic() external;
}

contract Sidekick {
  // call function
  function sendAlertBasic1(address hero) external {
    IHero(hero).alertBasic();
  }

  // call function signature
  function sendAlertBasic2(address hero) external {
    bytes4 signature = bytes4(keccak256("alertBasic()"));

    (bool success, ) = hero.call(abi.encodePacked(signature));

    require(success);
  }

  function sendAlert(address hero, uint enemies, bool armed) external {
    (bool success, ) = hero.call(
      abi.encodeWithSignature("alert(uint256,bool)", enemies, armed)
    );

    require(success);
  }

  function relay(address hero, bytes memory data) external {
    // send all of the data as calldata to the hero
    (bool success, ) = hero.call(data);

    require(success);
  }

  function makeContact(address hero) external {
    // trigger the hero's fallback function
    (bool success, ) = hero.call("gsdfgds");

    require(success);
  }
}