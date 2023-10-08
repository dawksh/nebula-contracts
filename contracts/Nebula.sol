// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Atom} from "./Atom.sol";

contract Nebula {
    error BondingFailed();

    function createBond(address _atom, bytes calldata data) external {
        Atom atom = Atom(_atom);
        bool success = atom.bond(data);
        if (!success) revert BondingFailed();
    }
}
