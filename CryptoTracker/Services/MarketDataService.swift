//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by M H on 17/09/2022.
//

import Foundation
import Combine

class MarketDataService {
	@Published var marketData: MarketDataModel? = nil
	var marketDataSubscribtion: AnyCancellable?
	
	init() {
		getData()
	}
	
	func getData() {
		guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {return}
		
		marketDataSubscribtion = NetworkingManager.downloadBackgroundThread(url: url)
			.decode(type: GlobalData.self, decoder: JSONDecoder())
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
				self?.marketData = returnedGlobalData.data
				self?.marketDataSubscribtion?.cancel()
				
			})
	}
}
