var Election = artifacts.require("./Election.sol");

contract("Election", function (accounts) {
    it("initializes with two candidates", function () {
        return Election.deployed().then(function (instance) {
            return instance.candidatesCount();
        }).then(function(count) {
            assert.equal(count, 2);
        });
    });

    var electionInstance

    function checkCandidate(i, candidate, name) {
        assert.equal(candidate[0], i, "contains the correct id")
        assert.equal(candidate[1], name, "contains the correct name")
        assert.equal(candidate[2], 0, "contains the correct votes count")
    }

    it("it intialzes the candidates with the correct values", function(){
        return Election.deployed().then(function(instance) {
            electionInstance = instance
            return electionInstance.candidates(1)
        }).then(function(candidate){
            checkCandidate(1, candidate, "Candidate 1")
            return electionInstance.candidates(2)
        }).then(function(candidate) {
            checkCandidate(2, candidate, "Candidate 2")
        })
    })
})