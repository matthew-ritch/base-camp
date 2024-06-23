// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ControlStructures} from "../src/ControlStructures.sol";

contract ControlStructuresTest is Test {
    ControlStructures public controlstructure;

    function test_fizzbuzz() public {
        controlstructure = new ControlStructures();
        string memory f = controlstructure.fizzBuzz(3);
        assertEq(f,"Fizz");
        string memory b = controlstructure.fizzBuzz(5);
        assertEq(b,"Buzz");
        string memory fb = controlstructure.fizzBuzz(15);
        assertEq(fb,"FizzBuzz");
        string memory s = controlstructure.fizzBuzz(16);
        assertEq(s,"Splat");
    }
    function test_dnd() public {
        controlstructure = new ControlStructures();
        string memory a = controlstructure.doNotDisturb(1801);
        assertEq(a,"Evening!");
        string memory b = controlstructure.doNotDisturb(1301);
        assertEq(b,"Afternoon!");
        string memory c = controlstructure.doNotDisturb(801);
        assertEq(c,"Morning!");
        vm.expectRevert();
        string memory d = controlstructure.doNotDisturb(1);
        vm.expectRevert();
        string memory e = controlstructure.doNotDisturb(2399);
    }
}
