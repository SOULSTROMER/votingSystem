// SPDX-License-Identifier: MIT

pragma solidity >= 0.8.0;
contract votingSystem{

    address public organiser;

    // uint time;
 
    struct voterCheck{
        address voterAddress;
        bool votePermit;
        bool voted;
    }
    voterCheck[] public voterList;

    mapping (address => voterCheck) voterMap;
    mapping (string => uint) public choiceMap;
    
    constructor(){
        organiser = msg.sender;
        choiceMap["red"] = 0;
        choiceMap["green"] = 0;
        choiceMap["blue"] = 0;
        //time = block.timestamp + 180;
    }

    modifier onlyOrganiser(){
        require(msg.sender == organiser,"Only for Organiser");
    _;}

    modifier checker(){
        require(voterMap[msg.sender].votePermit==true,"Not in the Voters List");
        require(voterMap[msg.sender].voted==false,"Already Casted the Vote");
    _;}

    // modifier timeStamp(){
    //     require(block.timestamp < time,"Election Over");
    // _;}

    function givingPermission(address _voterAddress) public onlyOrganiser {
        voterCheck memory _voterCheck = voterCheck(_voterAddress,true,false);
        voterList.push(_voterCheck);
        voterMap[_voterAddress] = _voterCheck;
    }

    function vote(string memory _choice) public checker {
        choiceMap[_choice] += 1;
        voterMap[msg.sender].voted = true;
    }

    function winner() public view onlyOrganiser returns(string memory,uint,uint){
        //require(block.timestamp>time);
        string memory _winner;
        _winner = "green";
        if (choiceMap["blue"] > choiceMap[_winner]){
            _winner = "blue";
        }
        if (choiceMap["red"]> choiceMap[_winner]){
            _winner = "red";
        }
        return (_winner,choiceMap[_winner],choiceMap["red"]+choiceMap["green"]+choiceMap["blue"]);
    // emit results(winner,choiceMap[winner],choiceMap["red"]+choiceMap["green"]+choiceMap["blue"])
    }

}