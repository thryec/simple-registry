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
    string name3 = "apple";

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

contract StateOneTest is StateOne {
    function testAddingSecondName() public {
        vm.prank(alice);
        registry.registerName(name2);
        address registeredHolder = registry.registry(name2);
        assertEq(registeredHolder, alice);
    }

    function testRevokingName() public {
        vm.prank(alice);
        registry.revokeName(name1);
        address registeredHolder = registry.registry(name1);
        assertEq(registeredHolder, address(0));
    }

    function testRevokingNameEmitsEvent() public {
        vm.expectEmit(true, true, true, true);
        emit RevokeName(alice, name1);
        vm.prank(alice);
        registry.revokeName(name1);
    }

    function testSecondUserAddName() public {
        vm.prank(bob);
        registry.registerName(name3);
        address registeredHolder = registry.registry(name3);
        assertEq(registeredHolder, bob);
    }
}
