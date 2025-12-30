// Token : smart contract based
// BIT, ETH, XRP, KAIA : native token
// SPDX-License-Identifer:MIT
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;

contract MyToken {
    string public name;
    string public symbol;
    uint8 public decimals; //1 ETH --> 1*10^18 wei / 1 wei --> 1*10^-18
    
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;


    constructor(string memory _name, string memory _symbol, uint8 _decimal) {
        name = _name;
        symbol = _symbol;
        decimals = _decimal;
// uint8 --> 8bit unsigned int , uint16, ... ,uint256
    }

//     function totalSupply() external view returns (uint256){
//         return totalSupply;
//     }
//     // 타입 지정은 returns
//     // external 외부 호출만 가능 public은 내부 외부 둘다 가능한 차이
//     function balanceOf(address owner) external view returns (uint256) {
//         return balanceOf[owner];
//     }
//     function name() external view returns (string memory) {
//         return name;
//     }
}