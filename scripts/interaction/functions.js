function getValue(contract) {
  return contract.value();
}

function setValue(contract) {
  return contract.modify(8);
}

function transfer(contract, friend) {
  return contract.transfer(friend, 800);
}

function setMessage(contract, signer) {
  return contract.connect(signer).modify('new msg');
}

async function deposit(contract) {
  const value = ethers.utils.parseEther('2');
  await contract.deposit({
    value
  });
}

function listen(contract) {
  contract.on('Deposit', () => contract.withdraw());
}

module.exports = {
  getValue,
  setValue,
  transfer,
  setMessage,
  deposit,
  listen,
}