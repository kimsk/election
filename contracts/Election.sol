pragma solidity ^0.4.2;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store Candidates
    mapping(address => bool) public voters;
    // Fetch Candidate
    mapping(uint => Candidate) public candidates;

    // Store Candidates Count
    uint public candidatesCount; // default is 0

    // Constructor
    constructor() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    event votedEvent (uint indexed _candidateId);

    function addCandidate (string _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function getVoteCount (uint _candidateId) public constant returns (uint voteCount) {
        return candidates[_candidateId].voteCount;
    }

    function vote (uint _candidateId /* solidity also pass meta data including caller here */) public {
        address sender = msg.sender;
        // pre-condition
        // 1. voter never votes before
        require(!voters[sender]);

        // 2. voter votes for valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);
        // record that voter has voted
        voters[sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}