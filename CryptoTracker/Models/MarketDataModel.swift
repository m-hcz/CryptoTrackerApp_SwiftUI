//
//  MarketDataModel.swift
//  CryptoTracker
//
//  Created by M H on 17/09/2022.
//

import Foundation

/*
 url = https://api.coingecko.com/api/v3/global
 

 {
 "data": {
 "active_cryptocurrencies": 12917,
 "upcoming_icos": 0,
 "ongoing_icos": 49,
 "ended_icos": 3376,
 "markets": 574,
 "total_market_cap": {
 "btc": 50678254.955957174,
 "eth": 699632523.8947101,
 "ltc": 17589256033.71134,
...
 "bits": 50678254955957.17,
 "sats": 5.067825495595717e+15
 },
 "total_volume": {
 "btc": 3001684.875761093,
 "eth": 41439397.773076855,
 "ltc": 1041815742.4355948,
 "bch": 488568595.82271993,
...
 "bits": 3001684875761.0933,
 "sats": 300168487576109.3
 },
 "market_cap_percentage": {
 "btc": 37.79374806146233,
 "eth": 17.207592480598233,
...
 "doge": 0.8098574720164089
 },
 "market_cap_change_percentage_24h_usd": 1.013254976577119,
 "updated_at": 1663429622
 }
 }
 */

struct GlobalData: Codable {
	let data: MarketDataModel?
}

struct MarketDataModel: Codable {
	let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
	let marketCapChangePercentage24HUsd: Double
	
	enum CodingKeys: String, CodingKey {
		case totalMarketCap = "total_market_cap"
		case totalVolume = "total_volume"
		case marketCapPercentage = "market_cap_percentage"
		case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
	}
	
	var marketCap:String {
		if let item = totalMarketCap.first(where: { $0.key == "usd"}) {
			return "$" + item.value.formattedWithAbbreviations()
		}
		return ""
	}
	
	var volume:String {
		if let item = totalVolume.first(where: { $0.key == "usd"}) {
			return "$" + item.value.formattedWithAbbreviations()
		}
		return ""
	}
	
	var btcDominance: String {
		if let item = marketCapPercentage.first(where: {$0.key == "btc"}) {
			return item.value.asPercentString()
		}
		return ""
	}
}
