// SPDX-License-Identifier: UNLICENSED
// Use the --constructor-args flag to pass arguments to the constructor:
// https://book.getfoundry.sh/forge/deploying
//forge create ./src/erc721Exercise.sol:HaikuNFT --rpc-url $BASE_SEPOLIA_RPC --account deployer  --verify --constructor-args a a

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract HaikuNFT is ERC721 {

    struct Haiku {
        address author;
        string line1;
        string line2;
        string line3;
    }

    Haiku[] public haikus;

    mapping (bytes32 => bool) public usedLines;

    mapping (address => uint[]) public sharedHaikus;

    uint public counter = 1;

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {
    }

    error HaikuNotUnique();

    function mintHaiku (string memory _line1, string memory _line2, string memory _line3) external {

        // check lines

        if ((usedLines[keccak256(bytes(_line1))]) || (usedLines[keccak256(bytes(_line2))]) || (usedLines[keccak256(bytes(_line3))])) {
            revert HaikuNotUnique();
        }

        // disable using these lines

        usedLines[keccak256(bytes(_line1))] = true;
        usedLines[keccak256(bytes(_line2))] = true;
        usedLines[keccak256(bytes(_line3))] = true;

        // add haiku
        
        Haiku storage haiku = haikus.push();
        haiku.author = msg.sender;
        haiku.line1 = _line1;
        haiku.line2 = _line2;
        haiku.line3 = _line3;
        _safeMint(msg.sender, counter++);
    }

    error NotYourHaiku();

    function shareHaiku (uint _id, address _to) external {
        if (ownerOf(_id) != msg.sender) {
            revert NotYourHaiku();
        }
        sharedHaikus[_to].push(_id);
    }

    error NoHaikusShared();

    function getMySharedHaikus() external view returns (Haiku[] memory) {
        uint[] memory list = sharedHaikus[msg.sender];
        if (list.length == 0) {
            revert NoHaikusShared();
        }
        Haiku[] memory output = new Haiku[](list.length);
        for (uint i; i<list.length; i++) {
            output[i] = haikus[list[i]-1];
        }
        return output;
    }
}