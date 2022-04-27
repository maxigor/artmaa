// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Marketplace is ReentrancyGuard {
	address payable public immutable feeAccount; //recebe as taxas
	uint public immutable feePercent; // porcentagem da venda
	uint public itemCount;


	struct Item {
		uint itemId;
		IERC721 nft;
		uint tokenId;
		uint price;
		address payable seller;
		bool sold;
	}

	mapping(uint => Item) public items;

	constructor(uint _feePercent) {
		feeAccount = payable(msg.sender);
		feePercent = _feePercent;
	}

	function makeItem(IERC721 _nft, uint _tokenId, uint _price ) external nonReentrant {
		require(_price > 0, "Price must be greater than zero.")

		//increment itemCount
		itemCount++;

		//transfer nft
		_nft.transferFrom(msg.sender, address(this), _tokenId);

		// add new item to items mapping
		items[itemCount] = Item (
			itemCount,
			_nft,
			_tokenId,
			_price,
			payable(msg.sender),
			false
		);
	}
}