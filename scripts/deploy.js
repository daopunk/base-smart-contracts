const hre = require("hardhat");

async function main() {
  const Example = await hre.ethers.getContractFactory("Example");
  const contractX = await Example.deploy();

  await contractX.deployed();

  console.log(`Address: ${contractX.address}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
