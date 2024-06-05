// SPDX-License-Identifier: UNLICENSED
// Use the --constructor-args flag to pass arguments to the constructor:
// https://book.getfoundry.sh/forge/deploying
pragma solidity ^0.8.13;

contract FavoriteRecords {
    mapping (string => bool) public approvedRecords;
    mapping (address => mapping (string => bool)) public userFavorites;
    mapping (address => string[]) public userFavoritesList;
    string[] approved_records;

    constructor() {
        approvedRecords["Thriller"] = true;
        approvedRecords["Back in Black"] = true;
        approvedRecords["The Bodyguard"] = true;
        approvedRecords["The Dark Side of the Moon"] = true;
        approvedRecords["Their Greatest Hits (1971-1975)"] = true;
        approvedRecords["Hotel California"] = true;
        approvedRecords["Come On Over"] = true;
        approvedRecords["Rumours"] = true;
        approvedRecords["Saturday Night Fever"] = true;

        approved_records.push("Thriller");
        approved_records.push("Back in Black");
        approved_records.push("The Bodyguard");
        approved_records.push("The Dark Side of the Moon");
        approved_records.push("Their Greatest Hits (1971-1975)");
        approved_records.push("Hotel California");
        approved_records.push("Come On Over");
        approved_records.push("Rumours");
        approved_records.push("Saturday Night Fever");
    }

    function getApprovedRecords() public view returns(string[] memory) {
        return approved_records;
    }

    function in_approved_records(string calldata x) public view returns (bool) {
        for (uint i = 0; i < approved_records.length; i++) {
            if (keccak256(abi.encode(approved_records[i])) == keccak256(abi.encode(x))) {
                return true;
            }
        }
        return false;
    }

    error NotApproved(string);

    function addRecord(string calldata x) public {
        if (in_approved_records(x)){
            userFavorites[msg.sender][x] = true;
            //add to userFavorites list
            string[] memory user_list = userFavoritesList[msg.sender];
            bool check = false;
            for (uint i = 0; i < user_list.length; i++) {
                if (keccak256(abi.encode(user_list[i])) == keccak256(abi.encode(x))) {
                    check = true;
                }
            }
            if (!check) {
                userFavoritesList[msg.sender].push(x);
                userFavorites[msg.sender][x] = true;
            }

        }
        else {
            revert NotApproved(x);
        }
    }

    function getUserFavorites(address x) public returns(string[] memory) {
        return userFavoritesList[x];
    }

    function resetUserFavorites() public {
        for (uint i=0; i<userFavoritesList[msg.sender].length; i++) {
            userFavorites[msg.sender][userFavoritesList[msg.sender][i]] = false;
        }
        delete userFavoritesList[msg.sender];
    }





}