const { expect } = require("chai");
const { ethers } = require("hardhat")

describe("NFTMarketplace" , function(){
	//variavel das contas
	let deployer , addr1 ,addr2;
	let feePercent = 1;
	let URI = "Sample URI"

	beforeEach(async function() {
		//pegando os contratos
		const NFT = await ethers.getContractFactory("NFT");
		const Marketplace = await ethers.getContractFactory("Marketplace");
		
		//contas
		[deployer , addr1 , addr2] = await ethers.getSigners();
		nft = await NFT.deploy();
		marketplace = await Marketplace.deploy(feePercent);
	});
	describe("Deployment", function(){
		it("Should track name and symbol of the nft collection", async function(){
			expect(await nft.name()).to.equal("NFT");
			expect(await nft.symbol()).to.equal("Dapp");

		})
	})
	describe("Minting NFT" , function() { 
		it("Should track each minted NFT" , async function(){
			await nft.connect(addr1).mint(URI)
			expect(await nft.tokenCount()).to.equal(1);
			expect(await nft.balanceOf(addr1.address)).to.equal(1);
			expect(await nft.tokenURI(1)).to.equal(URI);

		})
	})
})