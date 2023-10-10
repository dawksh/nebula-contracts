// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {IAtom} from "./IAtom.sol";
import {Registry} from "./AtomRegistry.sol";

contract Nebula {
    Registry registry;

    constructor(address _registry) {
        registry = Registry(_registry);
    }

    event BondCreated(bytes32 indexed atom, address element, bytes32 atomUid);

    error BondingFailed();

    function createBond(bytes32 _atom, bytes calldata data) external {
        IAtom atom = IAtom(registry.resolve(_atom));
        (bool success, bytes32 uid) = atom.bond(data);
        if (!success) revert BondingFailed();
        emit BondCreated(_atom, msg.sender, uid);
    }
}
