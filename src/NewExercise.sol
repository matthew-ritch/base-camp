// SPDX-License-Identifier: UNLICENSED
// Use the --constructor-args flag to pass arguments to the constructor:
// https://book.getfoundry.sh/forge/deploying
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";

contract AddressBook is Ownable {

    constructor(address initialOwner) Ownable(initialOwner) {}

    struct Contact {
        uint id;
        string firstName;
        string lastName;
        uint[] phoneNumbers;
    }

    Contact[] contacts;

    function addContact(uint _id, 
                        string calldata _firstName, 
                        string  calldata _lastName, 
                        uint[] calldata _phoneNumbers) 
                        public onlyOwner {
        Contact storage c = contacts.push();
        c.id = _id;
        c.firstName = _firstName;
        c.lastName = _lastName;
        c.phoneNumbers = _phoneNumbers;
    }

    function deleteContact(uint _id) public onlyOwner {
        contacts[_id] = contacts[contacts.length - 1];
        contacts.pop();
    }

    error ContactNotFound();

    function getContact(uint _id) public view returns (Contact memory){
        for (uint i; i < contacts.length; i++) {
            if (contacts[i].id == _id){
                return contacts[i];
            }
        }
        revert ContactNotFound();
    }

    function getAllContacts(uint _id) public view returns (Contact[] memory){
        return contacts;
    }

}

contract AddressBookFactory {
    function deploy() public returns (address) {
        AddressBook addressbook = new AddressBook(msg.sender);
        return address(addressbook);
    }
}