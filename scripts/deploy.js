const { ethers } = require('hardhat');

async function main() {
  const PokemonWorld = await ethers.getContractFactory('PokemonWorld');
  const pokemonWorld = await PokemonWorld.deploy('PokemonWorld', 'PKMN');

  await pokemonWorld.deployed();
  console.log('Success! Contract was deployed to: ', pokemonWorld.address);

  await pokemonWorld.mint(
    'https://ipfs.io/ipfs/QmNbdkUdVBL4dFeEGr7gB22hPJ5HroBVbnFPWGdYjoCEg9'
  );
  console.log('Bulbasaur #001 NFT successfully minted!');
  await pokemonWorld.mint(
    'https://ipfs.io/ipfs/QmTHEcjRQWarHFdwsokfkKgWs2jBzQtaRr9NBJLNTXxzYN'
  );
  console.log('Charmander #004 NFT successfully minted!');
  await pokemonWorld.mint(
    'https://ipfs.io/ipfs/QmTEjHEyrbhqeeJq54DgkvwWUhhrteMh26dAkUmP6rzhbX'
  );
  console.log('Squirtle #007 NFT successfully minted!');
  await pokemonWorld.mint(
    'https://ipfs.io/ipfs/QmZc7yVHFnb1MWb59Q26Gq3vM5YZvM9agTf8CbBexCEa9C'
  );
  console.log('Pikachu #025 NFT successfully minted!');

  console.log('Minting successful!');
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
