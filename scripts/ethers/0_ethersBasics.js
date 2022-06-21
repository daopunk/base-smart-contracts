const ethers = require('ethers');
const { Wallet, utils, providers } = ethers;

// create a wallet with a private key or mnemonic
const wallet1 = new Wallet('');
const wallet2 = new Wallet.fromMnemonic('');

// get node provider
const provider = new providers.Web3Provider(/** provider */);

// create connected wallet with private key and provider
const wallet = new Wallet(PRIVATE_KEY, provider);

const signaturePromise = wallet1.signTransaction({
  value: utils.parseUnits('1','ether'),
  to: "0xdD0DC6FB59E100ee4fA9900c2088053bBe14DE92", 
  gasLimit: 0x5208,
  gasPrice: utils.parseUnits('1', 'gwei')
});

async function sendEther({ value, to }) {
  return await wallet.sendTransaction({ 
    value, to, 
    gasLimit: 0x5208,
    gasPrice: 10**9
  });
}

function findMyBalance(privateKey) {
  // retrieve the balance, given a private key
  const w = new Wallet(privateKey, provider);
  return w.getBalance();
}

async function donate(privateKey, charities) {
  const w = new Wallet(privateKey, provider);

  for (let i = 0; i<charities.length; i++) {
    await w.sendTransaction({
      value: utils.parseEther("1.0"),
      to: charities[i]
    });
  }
}


module.exports = {
  signaturePromise,
  sendEther,
  findMyBalance,
  donate
}
