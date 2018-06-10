pragma solidity ^0.4.0;
import "./Flask.sol";
import "./SafeMath.sol";

contract FlaskWhiteList is Flask{
    
     mapping(address => bool) whitelist;
     address public owner;
     uint256 public total = 10000;
     
     
    using SafeMath for uint256;
     
    struct Contributor{
        string name;
        bool hasContributed;
    }
    mapping(address => Contributor) contributors;
    function FlaskWhiteList()public{
        owner = msg.sender;
        
    } 
     
    function buyToken(string _name)payable onlyWhitelist{
      require(msg.value == 10 ether && total >= 100 && contributors[msg.sender].hasContributed == false);
      balances[msg.sender] = 100;
      total.sub(100);
      contributors[msg.sender] = Contributor({
          name : _name,
          hasContributed: true
      });
    
        
    }
    function addWhiteList(address _address)public onlyOwner{
        whitelist[_address] = true;  
    }
    function removeWhiteList(address _address)public onlyOwner{
        whitelist[_address] = false;  
    }
    modifier onlyOwner(){
         require(msg.sender == owner);
         _;
    }
    modifier onlyWhitelist(){
        require(whitelist[msg.sender] == true);
        _;
    }
    
    
}
