// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SimpleStorage {
    uint8 public age = 26;
    uint8 public cars;

    constructor() {
        cars = 10;
    }
}
