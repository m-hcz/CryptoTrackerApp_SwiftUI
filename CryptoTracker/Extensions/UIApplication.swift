//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by M H on 17/09/2022.
//

import Foundation
import SwiftUI

extension UIApplication {
	func endEditing() {
		sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
