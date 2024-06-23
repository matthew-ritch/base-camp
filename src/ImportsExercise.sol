// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

library SillyStringUtils {

    struct Haiku {
        string line1;
        string line2;
        string line3;
    }

    function shruggie(string memory _input) internal pure returns (string memory) {
        return string.concat(_input, unicode" 🤷");
    }
}

contract ImportsExercise {
    using SillyStringUtils for SillyStringUtils.Haiku;

    SillyStringUtils.Haiku public haiku;

    function saveHaiku(string calldata x1, string calldata x2, string calldata x3) public {
        haiku.line1 = x1;
        haiku.line2 = x2;
        haiku.line3 = x3;
    }

    function getHaiku() public view returns(SillyStringUtils.Haiku memory) {
        return haiku;
    }

    function shruggieHaiku() public view returns(SillyStringUtils.Haiku memory) {
        SillyStringUtils.Haiku memory haiku2;
        haiku2.line1 = haiku.line1;
        haiku2.line2 = haiku.line2;
        haiku2.line3 = SillyStringUtils.shruggie(haiku.line3);
        return haiku2;
    }



} 