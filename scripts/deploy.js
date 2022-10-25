const { ethers } = require('hardhat');

async function main() {
  const PokemonWorld = await ethers.getContractFactory('PokemonWorld');
  const pokemonWorld = await PokemonWorld.deploy('PokemonWorld', 'PKMN');

  await pokemonWorld.deployed();
  console.log('Success! Contract was deployed to: ', pokemonWorld.address);

  await pokemonWorld.mint(
    'https://ipfs.io/ipfs/Qmc3EXicSsEjoE2N4QkZJSWRie7fQBBZwh4R5chBPRr9BH'
  );

  console.log('NFT successfully minted!');
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
