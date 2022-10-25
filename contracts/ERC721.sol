// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract ERC721 {

  event ApprovalForAll(address indexed _owner, address indexed _operator, bool _isApproved);
  event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);
  event Transfer(address indexed _from, address indexed _to, uint256 indexed tokenId);
  
  mapping(address => uint256) internal _balances;
  mapping(uint256 => address) internal _owners;
  mapping(address => mapping(address => bool)) private _operatorApprovals;
  mapping(uint256 => address) private _tokenApprovals;

  function balanceOf(address owner) public view returns(uint256) {
    require(owner != address(0), "Address is zero");
    return _balances[owner];
  }

  function ownerOf(uint256 tokenId) public view returns(address) {
    address owner = _owners[tokenId];
    require(owner != address(0), "Token ID doesn't exist");
    return owner;
  }

  function setApprovalForAll(address operator, bool isApproved) public {
    _operatorApprovals[msg.sender][operator] = isApproved;
    emit ApprovalForAll(msg.sender, operator, isApproved);
  }

  function isApprovedForAll(address owner, address operator) public view returns(bool) {
    return _operatorApprovals[owner][operator];
  }

  function approve(address to, uint256 tokenId) public {
    address owner  = ownerOf(tokenId);
    require(msg.sender == owner || isApprovedForAll(owner, msg.sender), "msg.sender is not the owner or an approved operator");
    _tokenApprovals[tokenId] = to;
    emit Approval(owner, to, tokenId);
  }

  function getApproved(uint256 tokenId) public view returns(address) {
    require(_owners[tokenId] != address(0), "Token ID does not exist");
    return _tokenApprovals[tokenId];
  }

  function transferFrom(address from, address to, uint256 tokenId) public {
    address owner = ownerOf(tokenId);
    require(
      msg.sender == owner ||
      getApproved(tokenId) == msg.sender ||
      isApprovedForAll(owner, msg.sender),
      "msg.sender is not the owner or someone approved for transfer"
    );
    require(owner == from, "From address is not the owner");
    require(to != address(0), "Address is zero");
    require(_owners[tokenId] != address(0), "Token ID does not exist");
    approve(address(0), tokenId);
    _balances[from] -= 1;
    _balances[to] += 1;
    _owners[tokenId] = to;

    emit Transfer(from, to, tokenId);
  }

  function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public {
    transferFrom(from, to, tokenId);
    require(_checkOnERC721Received(), "Receiver not implemented");
  }

  function safeTransferFrom(address from, address to, uint256 tokenId) public {
    safeTransferFrom(from, to, tokenId, "");
  }

  function _checkOnERC721Received() private pure returns(bool) {
    return true;
  }

  function supportsInterface(bytes4 interfaceId) public pure virtual returns(bool) {
    return interfaceId == 0x80ac58cd;
  }
}
