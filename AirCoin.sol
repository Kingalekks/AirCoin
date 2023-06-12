// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract AirCoin {
    // Token details
    string public name = "AirCoin";
    string public symbol = "AIR";
    uint256 public totalSupply = 10000000000000000;
    
    // Token balances mapping
    mapping(address => uint256) public balanceOf;
    
    // Token allowance mapping
    mapping(address => mapping(address => uint256)) public allowance;
    
    // Token voting event
    event Vote(address indexed voter, uint256 amount);
    
    // Constructor
    constructor(uint256 _totalSupply) {
        totalSupply = _totalSupply;
        balanceOf[msg.sender] = _totalSupply;
    }
    
    // Transfer tokens
    function transfer(address _to, uint256 _amount) external {
        require(balanceOf[msg.sender] >= _amount, "Insufficient balance");
        _transfer(msg.sender, _to, _amount);
    }
    
    // Internal transfer function
    function _transfer(address _from, address _to, uint256 _amount) internal {
        require(_to != address(0), "Invalid recipient");
        balanceOf[_from] -= _amount;
        balanceOf[_to] += _amount;
        emit Transfer(_from, _to, _amount);
    }
    
    // Approve spender to spend tokens
    function approve(address _spender, uint256 _amount) external {
        allowance[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
    }
    
    // Transfer tokens on behalf of
    function transferFrom(address _from, address _to, uint256 _amount) external {
        require(balanceOf[_from] >= _amount, "Insufficient balance");
        require(allowance[_from][msg.sender] >= _amount, "Unauthorized allowance");
        _transfer(_from, _to, _amount);
        allowance[_from][msg.sender] -= _amount;
    }
    
    // Vote for AirCash
    function vote(uint256 _amount) external {
        require(balanceOf[msg.sender] >= _amount, "Insufficient balance");
        balanceOf[msg.sender] -= _amount;
        emit Vote(msg.sender, _amount);
    }
    
    // Events
    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);
}
