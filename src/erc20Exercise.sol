// SPDX-License-Identifier: UNLICENSED
// Use the --constructor-args flag to pass arguments to the constructor:
// https://book.getfoundry.sh/forge/deploying

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

contract WeightedVoting is ERC20 {

    using EnumerableSet for EnumerableSet.AddressSet;

    uint public maxSupply = 1000000;
    address[] claimants;

    error TokensClaimed();
    error AllTokensClaimed();
    error NoTokensHeld();
    error QuorumTooHigh();
    error AlreadyVoted();
    error VotingClosed();

    struct Issue {
        EnumerableSet.AddressSet voters;
        string issueDesc;
        uint votesFor;
        uint votesAgainst;
        uint votesAbstain;
        uint totalVotes;
        uint quorum;
        bool passed;
        bool closed;
    }

    struct returnIssue {
        address[] voters;
        string issueDesc;
        uint votesFor;
        uint votesAgainst;
        uint votesAbstain;
        uint totalVotes;
        uint quorum;
        bool passed;
        bool closed;
    }

    Issue[] issues;
    enum Vote {
        AGAINST,
        FOR,
        ABSTAIN
    }


    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {
    }

    function claim () public {
        if (totalSupply() >= maxSupply) {
            revert AllTokensClaimed();
        }
        for (uint i; i<claimants.length; i++) {
            if (claimants[i] == msg.sender) {
                revert TokensClaimed();
            }
        }
        claimants.push(msg.sender);
        _update(address(0), msg.sender,100);
    }

    function createIssue(string calldata _issueDesc, uint _quorum) external returns (uint) {
        if (balanceOf(msg.sender) == 0) {
            revert NoTokensHeld();
        }
        if (_quorum > totalSupply()) {
            revert QuorumTooHigh();
        }


        Issue storage i = issues.push();
        i.issueDesc = _issueDesc;
        i.quorum = _quorum;

        return issues.length - 1;
    }

    function getIssue(uint _id) external view returns (returnIssue memory) {
        Issue storage iss = issues[_id];
        returnIssue memory ri;
        address[] memory voters = new address[](iss.voters.length());
        for (uint i = 0; i < iss.voters.length(); i++) {
            voters[i] = iss.voters.at(i);
        }

        ri.voters = voters;
        ri.issueDesc = iss.issueDesc;
        ri.votesFor = iss.votesFor;
        ri.votesAgainst = iss.votesAgainst;
        ri.votesAbstain = iss.votesAbstain;
        ri.totalVotes = iss.totalVotes;
        ri.quorum = iss.quorum;
        ri.passed = iss.passed;
        ri.closed = iss.closed;

        return ri;
    }

    function vote (uint _issueId, Vote _vote) public {
        Issue storage iss = issues[_issueId];

        if (iss.closed) {
            revert VotingClosed();
        }

        for (uint i = 0; i < iss.voters.length(); i++) {
            if (iss.voters.at(i) == msg.sender) {
                revert AlreadyVoted();
            }
        }

        if (_vote == Vote.FOR) {
            iss.votesFor += balanceOf(msg.sender);
        }
        if (_vote == Vote.AGAINST) {
            iss.votesAgainst += balanceOf(msg.sender);
        }
        if (_vote == Vote.ABSTAIN) {
            iss.votesAbstain += balanceOf(msg.sender);
        }

        iss.totalVotes += balanceOf(msg.sender);
        iss.voters.add(msg.sender);

        if (iss.totalVotes >= iss.quorum) {
            iss.closed = true;
            if (iss.votesFor > iss.votesAgainst) {
                iss.passed = true;
            }
        }

    }
}