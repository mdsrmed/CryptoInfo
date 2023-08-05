//
//  HapticManager.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 8/5/23.
//

import Foundation
import SwiftUI


class HapticManager {
    static let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred( type )
    }
}
