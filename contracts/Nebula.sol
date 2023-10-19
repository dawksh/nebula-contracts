// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {IAtom} from "./IAtom.sol";
import {Registry} from "./AtomRegistry.sol";
import {IWormholeRelayer} from "./wormhole/IWormholeRelayer.sol";
import {IWormholeReceiver} from "./wormhole/IWormholeReceiver.sol";

contract Nebula is IWormholeReceiver {
    Registry registry;
    IWormholeRelayer public immutable relayer;
    uint256 constant GAS_LIMIT = 100_000;

    mapping(bytes32 => bytes32) public crossChainBonds;

    constructor(address _registry, address _wormholeRelayer) {
        registry = Registry(_registry);
        relayer = IWormholeRelayer(_wormholeRelayer);
    }

    event BondCreated(bytes32 indexed atom, address element, bytes32 atomUid);
    event UnBond(bytes32 indexed atom, address element, bytes32 atomUid);
    event CrossChainBondCreated(
        bytes32 indexed atom,
        bytes32 atomUid,
        uint256 originChain
    );
    event CrossChainBondSent(
        bytes32 indexed atom,
        bytes32 atomUid,
        uint256 outboundChain
    );

    error BondingFailed();
    error InvalidBond();

    function createBond(bytes32 _atom, bytes calldata data) external {
        IAtom atom = IAtom(registry.resolve(_atom));
        (bool success, bytes32 uid) = atom.bond(abi.encode(msg.sender, data));
        if (!success) revert BondingFailed();
        emit BondCreated(_atom, msg.sender, uid);
    }

    function unbond(bytes32 _atom, bytes calldata data) external {
        IAtom atom = IAtom(registry.resolve(_atom));
        bytes32 uid = atom.unbond(abi.encode(msg.sender, data));
        emit UnBond(_atom, msg.sender, uid);
    }

    // Crosschain part

    function quoteCrossChain(
        uint16 targetChain
    ) public view returns (uint256 cost) {
        (cost, ) = relayer.quoteEVMDeliveryPrice(targetChain, 0, GAS_LIMIT);
    }

    function sendCrossChain(
        uint16 targetChain,
        address targetAddress,
        bytes32 atom,
        bytes32 atomUid
    ) external payable returns (uint64 deliveryHash) {
        (uint256 cost, ) = relayer.quoteEVMDeliveryPrice(
            targetChain,
            0,
            GAS_LIMIT
        );
        if (msg.value != cost) revert();
        IAtom atomContract = IAtom(registry.resolve(atom));
        bool v = atomContract.verifyBond(abi.encode(atomUid));
        if (!v) revert InvalidBond();
        deliveryHash = relayer.sendPayloadToEvm{value: msg.value}(
            targetChain,
            targetAddress,
            abi.encode(atom, atomUid, block.chainid),
            0,
            GAS_LIMIT
        );
        emit CrossChainBondSent(atom, atomUid, targetChain);
    }

    function receiveWormholeMessages(
        bytes memory payload,
        bytes[] memory, // additionalVaas
        bytes32 sourceAddress,
        uint16 sourceChain,
        bytes32 // deliveryHash
    ) public payable override {
        (bytes32 atom, bytes32 atomUid, uint256 originChain) = abi.decode(
            payload,
            (bytes32, bytes32, uint256)
        );
        if (originChain == block.chainid) revert();
        if (crossChainBonds[atom] != bytes32(0)) revert();
        crossChainBonds[atom] = atomUid;
        emit CrossChainBondCreated(atom, atomUid, originChain);
    }
}
