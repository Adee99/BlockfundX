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
        campaign.title = _title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.image = _image;
        
        campaign.collectedAmount = 0;
        numberOfCampaigns++;

        return numberOfCampaigns - 1;
    }

    function donateCampaign(uint256 _id) public payable{
        uint256 amount = msg.value;

        Campaign storage campaign = campaigns[_id];

        campaign.donators.push(msg.sender);
        campaign.donations.push(amount);

        (bool sent, ) = payable(campaign.owner).call{value: amount}("");

        if(sent){
            campaign.collectedAmount = campaign.collectedAmount + amount;
        }

    }

    function getDonators(uint256 _id) view public returns (address[] memory,uint256[] memory){
        return (campaigns[_id].donators, campaigns[_id].donations);
    }

    function getCampaigns() public view returns (Campaign[] memory){
        Campaign[] memory allCampaigns = new Campaign[](numberOfCampaigns); 

        for (uint i = 0; i < numberOfCampaigns; i++){
            Campaign storage item = campaigns[i];

            allCampaigns[i] = item;
        }

        return allCampaigns;
    }

}
