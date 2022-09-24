//
//  HapticManager.swift
//  CryptoTracker
//
//  Created by M H on 18/09/2022.
//

import Foundation
import SwiftUI

class HapticManager {
	static private let generaotr = UINotificationFeedbackGenerator()
	
	static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
		generaotr.notificationOccurred(type)
	}
}
