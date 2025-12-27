// Token : smart contract based
// BIT, ETH, XRP, KAIA : native token
// SPDX-License-Identifer:MIT
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;

contract MyToken {
    string public name;
    string public symbol;
    uint8 public decimals; //1 ETH --> 1*10^18 wei / 1 wei --> 1*10^-18

    constructor(string memory _name, string memory _symbol, uint8 _decimal) {
        name = _name;
        symbol = _symbol;
        decimals = _decimal;
// uint8 --> 8bit unsigned int , uint16, ... ,uint256
    }
}