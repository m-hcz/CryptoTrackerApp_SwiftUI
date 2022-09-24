//
//  NetworkingManager.swift
//  CryptoTracker
//
//  Created by M H on 16/09/2022.
//

import Foundation
import Combine

class NetworkingManager {
	
	enum NetworkingError: LocalizedError {
		case badURLResponse(url:URL)
		case unknow
		
		var errorDescription: String? {
			switch self {
				case .badURLResponse(url: let url): return "Bad response from URL: \(url)"
				case .unknow: return "Unknown error occured."
			}
		}
	}
	
	static func downloadBackgroundThread(url:URL) -> AnyPublisher<Data, Error> {
		return URLSession.shared.dataTaskPublisher(for: url)
			//.subscribe(on: DispatchQueue.global(qos: .default)) // is automatically on background thread
			.tryMap({ try handleURLResponse(output: $0, url: url)	})
			//.receive(on: DispatchQueue.main)
			.retry(3)
			.eraseToAnyPublisher()
	}
	
	static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url:URL) throws -> Data {
		guard
			let response = output.response as? HTTPURLResponse,
			response.statusCode >= 200 && response.statusCode < 300 else {
			throw NetworkingError.badURLResponse(url: url)
		}
		return output.data
	}
	
	static func handleCompletion(completion: Subscribers.Completion<Error>) {
		switch completion {
			case .finished:
				print("completion finnised")
				break
			case .failure(let error):
				print(error.localizedDescription)
		}
	}
}
