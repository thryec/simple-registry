// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/SimpleNameRegistry.sol";
import {Vm} from "forge-std/Vm.sol";

abstract contract StateZero is Test {
    SimpleNameRegistry public simpleNameRegistry;
    string name1 = "hello";
    string name2 = "world";

    function setUp() public virtual {
        simpleNameRegistry = new SimpleNameRegistry();
    }
}

contract StateZeroTest is StateZero {
    function testRegister() public {
        bytes32 registeredName = simpleNameRegistry.registerName(name1);
        console2.logBytes32(registeredName);
    }
}
