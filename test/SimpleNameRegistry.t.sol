// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/SimpleNameRegistry.sol";
import {Vm} from "forge-std/Vm.sol";

// vm deployer address: 0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84

abstract contract StateZero is Test {
    SimpleNameRegistry public registry;
    address alice;
    address bob;

    string name1 = "hello";
    string name2 = "world";

    event RegisterName(address indexed registrant, string indexed name);
    event RevokeName(address indexed registrant, string indexed name);

    error AlreadyRegistered();
    error NotOwner();

    function setUp() public virtual {
        registry = new SimpleNameRegistry();
        alice = address(0x1);
        bob = address(0x2);
        vm.label(alice, "alice");
        vm.label(bob, "bob");
    }
}

contract StateZeroTest is StateZero {
    function testRegister() public {
        vm.prank(alice);
        registry.registerName(name1);
        address registeredHolder = registry.registry(name1);
        assertEq(registeredHolder, alice);
    }

    function testRegisterEmitsEvent() public {
        vm.expectEmit(true, true, true, true);
        emit RegisterName(alice, name1);
        vm.prank(alice);
        registry.registerName(name1);
    }

    function testRevokeFailsWithError() public {
        vm.expectRevert(NotOwner.selector);
        vm.prank(alice);
        registry.revokeName(name1);
    }
}

abstract contract StateOne is StateZero {
    function setUp() public virtual override {
        super.setUp();

        vm.prank(alice);
        registry.registerName(name1);
    }
}
