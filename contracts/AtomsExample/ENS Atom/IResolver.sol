// SPDX-License-Identifier: GPLv3

pragma solidity ^0.8.11;

interface IPublicResolver {
    function addr(bytes32) external view returns (address);
}
