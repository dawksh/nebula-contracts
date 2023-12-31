# nebula protocol

A permissionless standardized onchain identity oracle protocol.

## how does it work?

in nebula protocol, we have the main protocol called nebula which consists of elements, which are the users to whom, the identities, in the protocol terms, atoms are associated to.

so,
<br/>
user = element
<br/>
identity = atom

every element can own a collection of atoms. these atoms are a set of smart contract which can have custom logic for issuance or and verification of the identity of an element. any issuer can write these smart contracts to add more functionality to these idenities, supercharging identities in short.

an example atom can be found in `/contracts/AtomsExample/ENS Atom` folder. `ENSAtom.sol` contains the code for smart contract for issuing ENS identities.

possibilities are endless. never stop building 🛠️

## todos

- [x] atom Basic Structure
- [x] creating a Bond
- [x] registering a Atom
- [x] breaking bonds
- [x] an example Atom (thinking ENS right now)


## deployments

### v 0.0.2

This release brings out cross chain wormhole deployments.

#### Goerli

- [Registry](https://goerli.etherscan.io/address/0xf2807be61bf5aff82361da275baba1467c5b9604)
- [Nebula](https://goerli.etherscan.io/address/0x5c3EBd455a7844b9A701A0E4685F0C02a522E421)
- [ENSAtom](https://goerli.etherscan.io/address/0x0E58e5E5D927D319A46b8B554Df5d1C4AAdf6928)

- [Subgraph](https://thegraph.com/studio/subgraph/nebula-goerli/)

#### Polygon Mumbai

- [Registry](https://mumbai.polygonscan.com/address/0x7d1885662a7f021f4757f5be847e721a38826cdc)
- [Nebula](https://mumbai.polygonscan.com/address/0x5c3EBd455a7844b9A701A0E4685F0C02a522E421)

#### Avax Fuji Testnet
- [Regsitry](https://testnet.snowtrace.io/address/0x29ea9C5c8F765dfcDbfaA38FFe2bAB5116BC5ffb)
- [Nebula](https://testnet.snowtrace.io/address/0xce51B4485aaf9e72B03C566aC88454D85493785B)

### v 0.0.1

#### Sepolia
- [Registry](https://sepolia.etherscan.io/address/0x184e1f7aeed0c44cc7f8ea6cb14a598c09166352)
- [Nebula](https://sepolia.etherscan.io/address/0xf2807be61bf5aff82361da275baba1467c5b9604)
- [ENSAtom](https://sepolia.etherscan.io/address/0x77C48FEEc9a8e5BA7EF14823b9205f2aD907414D)

#### Goerli
- [Registry](https://goerli-optimism.etherscan.io/address/0x7d1885662A7f021F4757f5bE847e721A38826cdc)
- [Nebula](https://goerli-optimism.etherscan.io/address/0x184e1F7aeeD0c44cc7F8EA6cB14A598c09166352)
