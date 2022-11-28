// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SimpleNameRegistry {
    mapping(address => bytes32[]) registry;
    mapping(address => uint256) namesPerUser;

    function registerName(string memory name)
        public
        returns (bytes32 registeredName)
    {
        bytes32 hashedName = keccak256(abi.encodePacked(name));
        registry[msg.sender][0] = hashedName;
        return hashedName;
    }
}
