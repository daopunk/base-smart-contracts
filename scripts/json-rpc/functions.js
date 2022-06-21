let provider; // add provider

async function getBlockNumber() {
  const response = await provider.send({
    jsonrpc: "2.0",
    id: 1,
    method: "eth_blockNumber"
  });

  return response.result;
}

async function getBalance(address) {
  const response = await provider.send({
    jsonrpc: "2.0",
    id: 1,
    method: "eth_getBalance", // <-- fill in the method
    params: [address, "latest"],  // <-- fill in the params
  });

  return response.result;
}

async function getNonce(address) {

  const response = await provider.send({
    jsonrpc: "2.0",
    id: 1,
    method: "eth_getTransactionCount", // <-- fill in the method
    params: [address, 'latest'], // <-- fill in the params
  });

  console.log(response.result);
  return response.result
  // return the nonce for the address
}

async function getTotalTransactions(blockNumber) {
  const hexBlockNum = `0x${blockNumber.toString(16)}`;

  const response = await provider.send({
    jsonrpc: "2.0",
    id: 1,
    method: "eth_getBlockByNumber",
    params: [hexBlockNum, false], 
  });

  console.log(response.result.transactions);
  return response.result.transactions.length;
  // return the total number of transactions in the block
}

async function getTotalBalance(addresses) {
  let res = [];
  let nonce = 1;

  for (let i=0; i<addresses.length; i++) {
    const req = await provider.send({
      jsonrpc: "2.0",
      id: nonce,
      method: "eth_getBalance",
      params: [addresses[i], 'latest'],
    });
    nonce++;
    res.push(req.result);
  }

  return res.reduce((acc, curr) => acc + parseInt(curr), 0);
}

module.exports = {
  getBlockNumber,
  getBalance,
  getNonce,
  getTotalTransactions,
  getTotalBalance
}