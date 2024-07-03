// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.5.0 <0.9.0;

contract Ebay {
    struct Auction {
        uint id;
        address payable seller;
        string name;
        string description;
        uint min;
        uint bestOfferId;
        uint[] offerIds;
    }

    struct Offer{
        uint id;
        uint auctionId;
        address payable buyer;
        uint price; 
    }

    mapping(uint => Auction) private auctions;
    mapping(uint => Offer) private offers;

    mapping(address => uint[]) private auctionList;
    mapping (address => uint[]) private offerList;

    uint private newAuctionId = 1;
    uint private newOfferId=1;

    function createAuction(string calldata _name, string calldata _description, uint _min) external  {
        require(_min > 0, "minimum must be greater than 0");
        uint[] memory offerIds = new uint[](0);

        auctions[newAuctionId]= Auction(newAuctionId, payable(msg.sender),_name, _description, _min, 0,offerIds);
        auctionList[msg.sender].push(newAuctionId);
        newAuctionId++;
    }

    function createOffer(uint _auctionId) external payable {
        Auction storage auction = auctions[_auctionId];
        Offer storage bestOffer = offers[auction.bestOfferId];

        require(msg.value >= auction.min  && msg.value > bestOffer.price, "msg.value must be greater hen the minimum and best offer");

        auction.bestOfferId = newOfferId;
        auction.offerIds.push(newOfferId);

        offers[newOfferId] = Offer(newOfferId,_auctionId, payable(msg.sender),msg.value);
        offerList[msg.sender].push(newOfferId);
        newOfferId++;


    }
}