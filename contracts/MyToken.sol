// Token : smart contract based
// BIT, ETH, XRP, KAIA : native token
// SPDX-License-Identifier:MIT
pragma solidity ^0.8.28;

import "./ManagedAccess.sol";

// managedaccess의 기능을 그대로 가져온다 - 상속
contract MyToken is ManagedAccess { 
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed spender, uint256 amount);

    string public name;
    string public symbol;
    uint8 public decimals; //1 ETH --> 1*10^18 wei / 1 wei --> 1*10^-18
    
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    // 데이터를 조회하는 것은 블록체인은 동일 노드이므로 동일한 값 리턴 . 중요한 어플리케이션이면 서로다른 노트에 데이터 조회
    // 동일하면 오염되지 않았다.  탈중앙화 데이터 무결성 검증 신뢰도 높은 어플리케이션


    constructor(string memory _name, string memory _symbol, uint8 _decimal, uint256 _amount
    ) ManagedAccess(msg.sender, msg.sender) {
        owner = msg.sender;
        manager = msg.sender;
        name = _name;
        symbol = _symbol;
        decimals = _decimal;
        _mint(_amount*10**uint256(decimals), msg.sender); //1MT
        // transaction
        // from , to, data, value, gas, ...
        // uint8 --> 8bit unsigned int , uint16, ... ,uint256
    }


    function approve(address spender, uint256 amount) external{
        allowance[msg.sender][spender] = amount;
        emit Approval(spender, amount);
    }
    // transferFrom 은 owner을 첫번째 parameter로 받음
    function transferFrom(address from, address to, uint256 amount) external{
        address spender = msg.sender;
        require(allowance[from][spender] >= amount, "insufficient allowance");
        require(balanceOf[from] >= amount, "insufficient balance");
        allowance[from][spender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        emit Transfer(from, to, amount);
    }
    
    function mint(uint256 amount, address to) external onlyManager {
        _mint(amount, to);
    }

    function setManager(address _manager) external onlyOwner {
        manager = _manager;
    }

    function _mint(uint256 amount, address to) internal {
        totalSupply += amount;
        balanceOf[to] += amount;

        emit Transfer(address(0), to, amount);
    }
    function transfer(uint256 amount, address to) external {
        require(balanceOf[msg.sender] >= amount, "insufficient balance");

        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;

        emit Transfer(msg.sender, to, amount);
    }
    function faucet(uint256 amount) external {
    _mint(amount, msg.sender);
}
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


// /*
// approve 토큰 권한 주는 것 
// - allow spender address to send my token
// transferFrom
// - spender : owner -> target address

// * token owner --> bank contract
// * token owner --> router contract --> bank contract
// * token owner --> router contract --> bank contract(multi contract)