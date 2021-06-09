// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

/// @title ERC20 Token
/// @author Sylvie Mémain-Yé

import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./SmyToken.sol";

contract SmyTokenICO is Ownable {
    using Address for address payable;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    /*
    uint256 public const INITIAL_SUPPLY_ = 1000000 * 10**18; // Initial is the number of tokens that we want to sale
    uint256 public const RATE_ = 100 * 10**18; // is the number of tokens that will be sold per 1 Ether (1 Ethereum)
    uint256 public tokensSold = 0; // the number of tokens that have been sold
    uint256 public const TOKEN_RESERVE_ = 1000000 * 10**18; // is the number of tokens that you want to keep for yourself or company.
    uint256 public remainingTokens = 0; // is the number of tokens remaining that can be sold
    */

    SmyToken private _smytoken;
    uint256 private _totalSupply;
    uint256 public _rate = 1e9; // 1 Token (1 ETH)(1 x 10^18) pourra être obtenu pour 1 gwei 100;
    uint256 public _time;
    uint256 public _icoOpeningTime;
    uint256 public _icoClosingTime;
    uint256 public icoRunningTime;

    // EVENTS
    // This generates a public event on the blockchain that will notify clients

    event Transfered(address indexed sender, address indexed receiver, uint256 amount);
    event Withdrew(address indexed receiver, uint256);
    event Approval(address indexed _owner, address indexed _spender, uint256 amount);

    constructor(address smytokenAddress, uint256 totalSupply_) {
        _smytoken = SmyToken(smytokenAddress);
        require(msg.sender == _smytoken.owner(), "SmyTokenICO: only owner can use this contract");
        _rate = 1e9;
        _totalSupply = totalSupply_;
    }

    modifier icoOpeningTime {
        require(_icoClosingTime >= block.timestamp, "SmyTokenICO is close");
        _;
    }

    modifier icoClosingTime {
        require(_icoOpeningTime <= block.timestamp, "SmyTokenICO still running");
        _;
    }

    function buyTokens() public payable {
        require(msg.sender != owner(), "SmyTokenICO: The owner is not allow to buy tokens.");
        require(msg.sender != _smytoken.owner(), "SmyTokenICO: The owner of token is not allow to buy tokens.");
        uint256 amount = msg.value * _rate;
        _smytoken.transferFrom(_smytoken.owner(), msg.sender, amount);
    }

    function withdraw() public onlyOwner {}

    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(_balances[msg.sender] >= amount, "SmyTokenICO: Insufficient balance to transfer funds");
        require(_balances[recipient] + amount >= _balances[recipient], "SmyTokenICO: Transfer to the 0 address"); //receiver != address(0),
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        emit Transfered(msg.sender, recipient, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public returns (bool success) {
        require(amount <= _allowances[sender][msg.sender], "SmyTokenICO: transfer amount exceeds allowance");
        require(amount <= _balances[sender], "SmyTokenICO: Insufficient balance to transfer funds");
        require(recipient != address(0), "SmyTokenICO: transfer to the 0 address");
        _allowances[sender][msg.sender] -= amount;
        _balances[sender] -= amount;
        _balances[recipient] += amount;
        emit Transfered(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public {
        require(spender != address(0), "SmyTokenICO: approve to the 0 address");
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
    }
}
