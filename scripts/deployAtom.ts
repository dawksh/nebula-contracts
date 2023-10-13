import { ethers, run } from "hardhat";

async function main() {
    const atom = await ethers.deployContract("ENSAtom", ["0xf2807be61bf5aff82361da275baba1467c5b9604"]);

    await atom.waitForDeployment();

    console.log("Atom deployed to:", await atom.getAddress());

    try {
        await run("verify:verify", {
            address: await atom.getAddress(),
            constructorArguments: ["0xf2807be61bf5aff82361da275baba1467c5b9604"],
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
