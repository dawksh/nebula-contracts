// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.19;

contract Atom {
    address internal _nebula;
    address internal _issuer;

    error InvalidCaller();

    constructor(address __nebula) {
        _nebula = __nebula;
        _issuer = msg.sender;
    }

    modifier onlyNebula() {
        if (msg.sender != _nebula) revert InvalidCaller();
        _;
    }

    function bond(
        bytes calldata data
    ) external onlyNebula returns (bool, bytes32) {
        //  TODO
    }

    function unbond(bytes32 _data) external onlyNebula returns (bool) {
        //  TODO
    }

    function verifyBond(bytes32 _data) external returns (bool) {
        //  TODO
    }

    function issuer() external view returns (address) {
        return _issuer;
    }

    function nebula() external view returns (address) {
        return _nebula;
    }
}
