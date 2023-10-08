// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;

interface IAtom {
    function bond(bytes calldata data) external returns (bool);

    function unbond(bytes32 _data) external returns (bool);

    function verifyBond(bytes32 _data) external returns (bool);

    function issuer() external view returns (address);

    function nebula() external view returns (address);
}
