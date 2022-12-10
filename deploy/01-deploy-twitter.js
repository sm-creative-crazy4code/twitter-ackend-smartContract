const { ethers } = require("hardhat")
const{getNamedAccounts,deployments} =require("hardhat")

module.exports=async function({getNamedAccounts, deployments}){
    const {deploy, log} =  deployments;
    const{deployer} = await getNamedAccounts();
    log("deploying the smart contract ");
    const TwitterContract = await deploy("Twitter",{
        from: deployer,
        args:[],
        log:true,
        waitConfirmations: 1
    })

}

module.exports.tags=["all","twitter"]




/**LOCAL NETWORK
 * deployed at 0x5FbDB2315678afecb367f032d93F642f64180aa3 with 1222995 gas
 * 
 * 
 * GOERLI TESTNET
 * deploying "Twitter" (tx: 0x9291fc2e6d6512aca413d6c7fc728aab693cf0d69ebd850231bc6479ffe4d30d)...: deployed at 0x1ee67fA93E7B8a34fCD17FDDebCeDfE0B68D4A51 with 1713054 gas
 */