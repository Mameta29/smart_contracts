// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyNFT {
    uint256 public totalSupply;
    mapping (uint256 => address) public ownerOf;
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => bool)) public isApproved;

    constructor() {
        totalSupply = 0;
    }

    function mint() public {
        totalSupply += 1;
        balanceOf[msg.sender] += 1;
        ownerOf[totalSupply] = msg.sender;
    }

    function transferFrom(address from, address to, uint256 tokenId) public {
        require(ownerOf[tokenId] == from, "You do not own this token.");
        require(from == msg.sender || isApproved[from][msg.sender] == true, "You are not authorized to transfer this token.");

        ownerOf[tokenId] = to;
        balanceOf[from] -= 1;
        balanceOf[to] += 1;

        if (isApproved[from][msg.sender] == true) {
            isApproved[from][msg.sender] = false;
        }
    }
    
    function approve(address to, uint256 tokenId) public {
        require(msg.sender == ownerOf[tokenId], "You are not the owner of this token.");
        isApproved[msg.sender][to] = true;
    }
}
