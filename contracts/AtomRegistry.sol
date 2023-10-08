// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.19;

contract Registry {
    mapping(bytes32 => address) internal uidToAddressMap;

    function register(address atom) external returns (bytes32) {
        bytes32 uid = keccak256(abi.encodePacked(atom, msg.sender));
        uidToAddressMap[uid] = atom;
        return uid;
    }

    function resolve(bytes32 uid) external view returns (address) {
        return uidToAddressMap[uid];
    }
}
