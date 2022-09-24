//
//  CoinDetailDataService.swift
//  CryptoTracker
//
//  Created by M H on 21/09/2022.
//

import Foundation
import Combine

class CoinDetailDataService {
	@Published var coinDetails: CoinDetailModel? = nil
	var coinDetailSubscribtion: AnyCancellable?
	let coin:CoinModel
	
	init(coin:CoinModel) {
		self.coin = coin
		getCoins()
	}
	
	func getCoins() {
		guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {return}
		print(url)
		coinDetailSubscribtion = NetworkingManager.downloadBackgroundThread(url: url)
			.decode(type: CoinDetailModel.self, decoder: JSONDecoder())
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoinDetails in
				self?.coinDetails = returnedCoinDetails
				self?.coinDetailSubscribtion?.cancel()
				
			})
	}
}
