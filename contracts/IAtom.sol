// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;

interface IAtom {
    function bond(bytes calldata data) external returns (bool, bytes32);

    function unbond(bytes calldata data) external returns (bytes32);

    function verifyBond(bytes calldata data) external returns (bool);

    function issuer() external view returns (address);

    function nebula() external view returns (address);
}
