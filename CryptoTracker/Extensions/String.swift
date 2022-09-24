//
//  String.swift
//  CryptoTracker
//
//  Created by M H on 24/09/2022.
//

import Foundation


extension String {
	
	var removingHTMLOccurances: String {
		return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
	}
	
}
