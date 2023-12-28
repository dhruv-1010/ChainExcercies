require("dotenv").config();
const { ethers } = require("ethers");
const fs = require("fs-extra");

async function main() {
  const provider = new ethers.providers.JsonRpcProvider(process.env.RPC_URL);
  const wallet = new ethers.Wallet(process.env.WALLET_PVT_KEY, provider);
  // in order to deploy we need abi and bin
  const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf-8");
  const binary = fs.readFileSync(
    "./SimpleStorage_sol_SimpleStorage.bin",
    "utf-8",
  );
  //0x037F37045D3E05629548aCeF5ECB656C860d1292
  // now to make a contract factory object to deploy contracts
  const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
  console.log("Deploying, please wait...");
  const contract = await contractFactory.deploy();
  // const contract = await contractFactory.deploy({ gasPrice: 100000000000 })
  const deploymentReceipt = await contract.deployTransaction.wait(1);
  console.log(`Contract deployed to ${contract.address}`);
  // stop for contract to deploy
  // console.log(contract);
  // const deploymentReceipt = await contract.deployTransaction.wait(1);
  // // 1 block confirmation
  // console.log(deploymentReceipt);
  // console.log("lets deploy with transaction data");
  // const nonce = await wallet.getTransactionCount();
  // const tx = {
  //     nonce:nonce,
  //     gasPrice:2,
  //     gasLimit:1,
  //     to:null,
  //     value:0,
  //     chainId:1337,
  // };
  // const signedTx = await wallet.signTransaction(tx);
  // console.log(signedTx);
  // const sendTxResponse = await wallet.sendTransaction(tx);
  // await sendTxResponse.wait(1);
  // console.log(sendTxResponse);
  const currentFavouriteNumber = await contract.retrieve();
  console.log(`current: ${currentFavouriteNumber.toString()}`);
  const add = await contract.store("7");
  const addReciept = await add.wait(1);
  const updatedFavouriteNumber = await contract.retrieve();
  console.log(`updated: ${updatedFavouriteNumber.toString()}`);
}
// some additional security risks happen when we
//  do not use the enrypted json thing so we need to do this before any real fund wallets but i skipped this for noww
// additionally i can actually deploy this to a real blockchain
// s
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

// /this is our deployment server
// next we are going to do is get that
// rpc url
// now we can do this using an axios or fetch
// but standard procedure is to use
// a wrapper like ethers
// galanche blockchain
// 127.0.0.1:8545
