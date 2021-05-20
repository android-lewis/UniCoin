pragma solidity >=0.7.0 <0.9.0;

contract unicoin_ico {
    
	// Introduing the maximum number of UniCoins for sale
	uint public MAX_COINS = 1000000;
		
	// Conversion rate from UniCoin to USD
	uint public USD_CONVERSION = 1000;
			
	// Total number of UniCoins issued
	uint public ISSUED_COINS = 0;
					
	// Mapping to determine the equity of the investor address
	mapping(address => uint) COIN_EQUITY;
	mapping(address => uint) USD_EQUITY;
							
	// Checking if an investor can buy UniCoins
	modifier CAN_BUY_COINS(uint USD_INVESTED){
		require (USD_INVESTED * USD_CONVERSION + ISSUED_COINS <= MAX_COINS); // Linked function will only run if true
		_;
	}
											
	// Get equity in coins
	function EQUITY_IN_COINS(address investor) external returns (uint) {
		return COIN_EQUITY[investor];
	}
														
	// Get equity in USD
	function EQUITY_IN_USD(address investor) external returns (uint) {
		return USD_EQUITY[investor];
	}
																	
	// Buying UniCoins
	function BUY_COINS(address investor, uint usd_invested) external
		CAN_BUY_COINS(usd_invested){
		uint COINS_PURCHASED = usd_invested * USD_CONVERSION;
		COIN_EQUITY[investor] += COINS_PURCHASED;
		USD_EQUITY[investor] = COIN_EQUITY[investor] / USD_CONVERSION;
		ISSUED_COINS += COINS_PURCHASED;
	}
																										
	// Sell UniCoins
	function SELL_COINS(address investor,  uint coins_to_sell) external {
		COIN_EQUITY[investor] -= coins_to_sell;
		USD_EQUITY[investor] = COIN_EQUITY[investor] / USD_CONVERSION;
		ISSUED_COINS -= coins_to_sell;
	}
}
