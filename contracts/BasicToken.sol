pragma solidity ^0.4.24;

import "./ERC20Basic.sol";
import "./SafeMath.sol";

/**
 * @title Basic token
 * @dev Basic version of StandardToken, with no allowances.
 */
contract BasicToken is ERC20Basic {
    using SafeMath for uint256;

    mapping(address => uint256) balances;

    uint256 totalSupply_;

    /**
    * @dev Total number of tokens in existence
    */
    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }

    /**
    * @dev Transfer token for a specified address
    * @param _to The address to transfer to.
    * @param _value The amount to be transferred.
    */
    function transfer(address _to, uint256 _value) public returns (bool) {
        require(_to != address(0), "address not valid");
        require(_value <= balances[msg.sender], "balance not enough");

        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferMulti(address[] _tos, uint256[] _values) public returns (bool) {
        uint i;
        uint totalValue;

        require(_tos.length <= 100, "transfer counts cannot exceed 100");

        for(i = 0; i < _tos.length; i++) {
            require(_tos[i] != address(0), "address not valid");
            totalValue = totalValue.add(_values[i]);
        }
        require(totalValue <= balances[msg.sender], "balance not enough");

        for(i = 0; i < _tos.length; i++) {
            balances[msg.sender] = balances[msg.sender].sub(_values[i]);
            balances[_tos[i]] = balances[_tos[i]].add(_values[i]);
            emit Transfer(msg.sender, _tos[i], _values[i]);
        }
        return true;
    }

    /**
    * @dev Gets the balance of the specified address.
    * @param _owner The address to query the the balance of.
    * @return An uint256 representing the amount owned by the passed address.
    */
    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }
}