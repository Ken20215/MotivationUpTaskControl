//
//  PriorityModelView.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/07/17.
//

import SwiftUI
import Foundation

enum PriorityEnum: String {
    case emergencyHighAndImportantHigh = "緊急かつ重要"   // 緊急かつ重要
    case emergencyHighAndImportantLow =  "緊急かつ重要ではない"   // 緊急かつ重要ではない
    case emergencyLowAndImportantHigh = "緊急ではないが、重要"    // 緊急ではないが、重要
    case emergencyLowAndImportantLow  = "緊急ではないが、重要ではない"  // 緊急ではないが、重要ではない
    var displayString: String {
        switch self {
        case .emergencyHighAndImportantHigh:
            return "緊急かつ\n重要"
        case .emergencyHighAndImportantLow:
            return "緊急かつ\n重要でない"
        case .emergencyLowAndImportantHigh:
            return "緊急ではないが、\n重要"
        case .emergencyLowAndImportantLow:
            return "緊急ではないが、\n重要でない"
        }
    }
}
