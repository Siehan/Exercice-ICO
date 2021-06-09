// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

/// @title ERC20 Token
/// @author Sylvie Mémain-Yé

/**
 * @dev Les décimales sont uniquement à des fins de visualisation.
 * Toutes les opérations se font à l'aide de la plus petite et indivisible unité de jeton,
 * comme sur Ethereum toutes les opérations se font en wei.
 * Important: All currency math is done in the smallest unit of that currency,
 * which is not ETH (or TOMO) but wei. 1 ETH = 10¹⁸ wei
 */

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

//address owner_
//transferOwnership(owner_);
contract SmyToken is ERC20, Ownable {
    constructor(uint256 initialSupply_) ERC20("SmyToken", "SMY") Ownable() {
        _mint(msg.sender, initialSupply_ * 10**decimals()); //_mint(msg.sender, initialSupply_ * 10 ** uint(18));
    }
}

//1 Token (1 ETH)(1 x 10^18) pourra être obtenu pour 1 gwei

//_mint(msg.sender, 100 * 10 ** uint(decimals()));
// Mint 100 tokens to msg.sender
// Similar to how
// 1 dollar = 100 cents
