// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.19;

import {IPublicResolver} from "./IResolver.sol";
import {IENS} from "./IENS.sol";

contract ENSAtom {
    address internal _nebula;
    address internal _issuer;

    IENS internal ens = IENS(0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e);

    mapping(address => bytes32) internal _addressToUidMap;
    mapping(bytes32 => address) internal _uidToAddressMap;
    mapping(address => bytes32) internal addressToNodeMap;

    error InvalidCaller();
    error UIDExists();
    error UIDNotExists();

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
        (address sender, bytes32 node) = abi.decode(data, (address, bytes32));
        if (_addressToUidMap[sender] != bytes32(0)) revert UIDExists();
        IPublicResolver resolver = IPublicResolver(ens.resolver(node));
        address addr = resolver.addr(node);
        if (addr != sender) {
            return (false, bytes32(0));
        }
        bytes32 uid = keccak256(abi.encodePacked(addr, node));
        addressToNodeMap[sender] = node;
        _uidToAddressMap[uid] = sender;
        _addressToUidMap[sender] = uid;
        return (true, uid);
    }

    function unbond(bytes calldata _data) external onlyNebula returns (bool) {
        address sender = abi.decode(_data, (address));
        if (_addressToUidMap[sender] == bytes32(0)) revert UIDExists();
        delete _addressToUidMap[sender];
        return true;
    }

    function verifyBond(bytes calldata data) external returns (bool) {
        bytes32 uid = abi.decode(data, (bytes32));
        address sender = _uidToAddressMap[uid];
        if (_addressToUidMap[sender] == bytes32(0)) revert UIDNotExists();
        bytes32 node = addressToNodeMap[sender];
        IPublicResolver resolver = IPublicResolver(ens.resolver(node));
        address addr = resolver.addr(node);
        if (addr != sender) {
            delete _addressToUidMap[sender];
            delete addressToNodeMap[sender];
            return false;
        }
        return true;
    }

    function issuer() external view returns (address) {
        return _issuer;
    }

    function nebula() external view returns (address) {
        return _nebula;
    }
}
