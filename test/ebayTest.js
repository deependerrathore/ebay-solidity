const Ebay = artifacts.require("Ebay");
const { expectRevert } = require("@openzeppelin/test-helpers");

contract("Ebay", (accounts) => {
  let ebay;

  beforeEach(async () => {
    ebay = await Ebay.new();
  });

  const auction = {
    name: "auction 1",
    description: "Selling item 1",
    min: 10,
  };

  const [seller, buyer1, buyer2] = [accounts[0], accounts[1], accounts[2]];

  it("should create an auction", async () => {
    let auctions;

    await ebay.createAuction(auction.name, auction.description, auction.min);

    auctions = await ebay.getAuctions();

    assert(auctions.length === 1);
    assert(auctions[0].name === auction.name);
    assert(auctions[0].description === auction.description);
    assert(Number(auctions[0].min) === auction.min);
  });

  it("Should not create an offer if auction does not exist", async () => {
    await expectRevert(
      ebay.createOffer(1, { from: buyer1, value: auction.min + 10 }),
      "Auction does not exist"
    );
  });
});
