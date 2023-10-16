import { ethers, run } from "hardhat";

async function main() {
    const atom = await ethers.deployContract("ENSAtom", ["0x29ea9C5c8F765dfcDbfaA38FFe2bAB5116BC5ffb"]);

    await atom.waitForDeployment();

    console.log("Atom deployed to:", await atom.getAddress());

    try {
        await run("verify:verify", {
            address: await atom.getAddress(),
            constructorArguments: ["0x29ea9C5c8F765dfcDbfaA38FFe2bAB5116BC5ffb"],
        });
    } catch (error) {
        console.log(error);
    }


}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
