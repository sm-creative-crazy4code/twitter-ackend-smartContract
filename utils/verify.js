const run = require("hardhat")

module.exports =async function(contractAddress,args){

console.log("verifying contract on etherscan")

try {
    await run("verify:verify",{
        contractAddress:contractAddress,
        args:args,
    }
    )
    
} catch (e) {
    if (e.message.toLowerCase().includes("already verified")) {
        console.log("Already verified!")
    } else {
        console.log(e)
    }
    
}



}