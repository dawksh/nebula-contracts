// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Nebula {
    struct Element {
        string name;
        string value;
    }

    mapping(address => bytes32) internal userToStar;
    mapping(bytes32 => Element[]) internal starToElements;

    constructor() {}

    function createStar() external {
        // TODO
        // Create a new config (star) for a user
    }

    function modifyStar() external {
        // TODO
        // Modify an existing config (star) for a user
    }

    function deleteStar() external {
        // TODO
        // Delete an existing config (star) for a user
    }

    function proposeElements() external {
        // TODO
        // Have a consensus to add a new element to the star config
    }
}
