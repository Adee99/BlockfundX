// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Crowdfunding {
    struct Campaign {
        string title;
        string description;
        address owner;
        uint256 deadline;
        uint256 target;
        uint256 collectedAmount;
        string image; //image is string, cz gonna put a URL here
        address[] donators; //donators
        uint256[] donations;
    }

    mapping(uint256 => Campaign) public campaigns;

    uint256 public numberOfCampaigns = 0; //initializing a global var

    function createCampaign(address _owner, string memory _title, string memory _description, uint256 _target, uint256 _deadline, string memory _image) public returns(uint256){
        Campaign storage campaign = campaigns[numberOfCampaigns];

        //check if everythings fine
        require(campaign.deadline < block.timestamp, "Deadline should be a date in future");

        campaign.owner = _owner;
        campaign.deadline = _deadline;
        campaign.image = _image;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.collectedAmount = 0;
        campaign.title = _title;

        numberOfCampaigns++;

        return numberOfCampaigns - 1;
    }

    function donateCampaign(){}

    function getDonators(){}

    function getCampaigns(){}

}
