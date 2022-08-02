// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {

     constructor() ERC20("IEC Token", "IEC")  {}
      uint256 private Price = uint256(1);
  
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
   
    }
      // BuyToken function this function would transfer tokens only from the contract owner's address.
      // for make this function useable contract owner has to mint token first on his own address.

      function buyToken(uint tokenAmount) public payable{
        require(owner() != msg.sender, 
        "Owner can not buy");
        require(balanceOf(owner()) != 0,
        "Tokens are not minted by Owner");
        require(balanceOf(owner()) >= tokenAmount ,
        "Owner does not have enough Tokens to sell");
        require(tokenAmount * Price == msg.value/(1 ether),
        "Price Error: Please send exact amount of Ethers");

        payable(owner()).transfer(msg.value);
       _transfer(owner(),msg.sender,tokenAmount);

    }

    // Token Price Functions. Only owner can set token price. 
    // the set amount will be autometiclly convert in Ethers and intial price is 1 Eth.

    function setTokenPrice(uint256 _amount)public onlyOwner{ 
          Price = _amount;
        
    }
    function getTokenPrice()public view returns(uint256){ 
           
         return Price;
         
    }
      
  


}