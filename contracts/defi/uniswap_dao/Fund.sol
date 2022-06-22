// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
pragma abicoder v2;

// import "@uniswap/v3-core/contracts/interfaces/IERC20Minimal.sol";
// import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";
// import "@uniswap/v3-periphery/contracts/libraries/BytesLib.sol";
import "./ISwapRouter.sol";
import "./IERC20.sol";
import "./BytesLib.sol";

contract Fund {
  IERC20Minimal dai = IERC20Minimal(0x6B175474E89094C44Da98b954EedeAC495271d0F);
  ISwapRouter router = ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);

  address manager = msg.sender;
  uint256 initAmount;
  uint256 finalAmount;

  mapping (address => uint) public share;

  function deposit(uint _amount) external {
    dai.transferFrom(msg.sender, address(this), _amount);
    share[msg.sender] = _amount;
  }

  function invest(bytes memory path) external {
    require(msg.sender == manager);
    dai.approve(address(router), dai.balanceOf(address(this)));
    initAmount = dai.balanceOf(address(this));

    router.exactInput(ISwapRouter.ExactInputParams(path, address(this), block.timestamp, dai.balanceOf(address(this)), 0));
  }
  
  function divest(bytes memory path) external {
    require(msg.sender == manager);
    IERC20Minimal asset = IERC20Minimal(BytesLib.toAddress(path, 0));
    asset.approve(address(router), asset.balanceOf(address(this)));
    
    router.exactInput(ISwapRouter.ExactInputParams(path, address(this), block.timestamp, asset.balanceOf(address(this)), 0));
    finalAmount = dai.balanceOf(address(this));
  }

  function withdraw() external {
    uint payout = (share[msg.sender] * finalAmount) / initAmount;
    share[msg.sender] = 0;
    dai.transferFrom(address(this), payable(msg.sender), payout);
  }
}
