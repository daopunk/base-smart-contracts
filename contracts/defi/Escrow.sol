// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;
    bool public isApproved;

    event Approved(uint);

    modifier onlyArbiter() {
        require(msg.sender == arbiter);
        _;
    }

    constructor(address _arb, address _bene) payable {
        depositor = msg.sender;
        beneficiary = _bene;
        arbiter = _arb;
    }

    function approve() external onlyArbiter {
        uint bal = address(this).balance;
        payable(beneficiary).transfer(bal);
        emit Approved(bal);
        isApproved = true;
    }
}

/** 
// scripts: deploy, approve, listen

function deploy(abi, bytecode, signer, arbiterAddress, beneficiaryAddress) {

  const contractFactory = new ethers.ContractFactory(abi, bytecode, signer);
  
  return contractFactory.deploy(arbiterAddress, beneficiaryAddress, {
    value: ethers.utils.parseEther("1")
  });
}

function approve(contract, arbiterSigner) {
  return contract.connect(arbiterSigner).approve();
}

function listen(contract, escrowState) {
  contract.once("Approved", () => {
    escrowState.isApproved = true;
  });
}

*/