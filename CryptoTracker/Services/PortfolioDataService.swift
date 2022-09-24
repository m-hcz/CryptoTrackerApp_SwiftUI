//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by M H on 18/09/2022.
//

import Foundation
import CoreData

class PortfolioDataService {
	private let container : NSPersistentContainer
	private let containerName: String = "PortfolioContainer"
	private let portfolioEntity:String = "PortfolioEntity"
	@Published var savedEntities: [PortfolioEntity] = []
	
	init() {
		container = NSPersistentContainer(name: containerName)
		container.loadPersistentStores { _, error in
			if let error = error {
				print("Error loading Cora Data: \(error)")
			}
			self.getPortfolio()
		}
	}
	
	// MARK: public func
	func updatePortfolio(coin: CoinModel, amount: Double) {
		// if coin exists in portfolio
		if let entity = savedEntities.first(where: {$0.coinID == coin.id}) {
			if amount > 0 {
				update(entity: entity, amount: amount)
			} else {
				delete(entity: entity)
			}
		} else {
			add(coin: coin, amount: amount)
		}
	}
	
	// MARK: private func
	private func getPortfolio() {
		let request = NSFetchRequest<PortfolioEntity>(entityName: portfolioEntity)
		do {
			savedEntities = try container.viewContext.fetch(request)
		} catch let error {
			print("Error fetching portfolio entitties: \(error)")
		}
	}
	
	private func add(coin: CoinModel, amount:Double) {
		let entity = PortfolioEntity(context: container.viewContext)
		entity.coinID = coin.id
		entity.amount = amount
		
		applyCahnges()
	}
	
	private func update(entity: PortfolioEntity, amount:Double) {
		entity.amount = amount
		applyCahnges()
	}
	
	private func delete(entity: PortfolioEntity) {
		container.viewContext.delete(entity)
		applyCahnges()
	}
	
	private func save() {
		do {
			try container.viewContext.save()
		} catch let error {
			print("Erorr savind to Cora Data: \(error)")
		}
	}
	
	private func applyCahnges() {
		save()
		getPortfolio()
	}
}
