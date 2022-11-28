// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "lib/openzeppelin-contracts/contracts/utils/Counters.sol";

contract SimpleNameRegistry {
    mapping(string => address) public registry;

    event RegisterName(address indexed registrant, string indexed name);
    event RevokeName(address indexed registrant, string indexed name);

    error AlreadyRegistered();
    error NotOwner();

    function registerName(string memory name) public {
        if (registry[name] != address(0)) {
            revert AlreadyRegistered();
        }
        registry[name] = msg.sender;
        emit RegisterName(msg.sender, name);
    }

    function revokeName(string memory name) public {
        if (registry[name] != msg.sender) {
            revert NotOwner();
        }

        delete registry[name];
        emit RevokeName(msg.sender, name);
    }
}
