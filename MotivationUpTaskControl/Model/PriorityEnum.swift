//
//  PriorityEnum.swift
//  motivationUpTaskControl
//
//  Created by 藤治仁 on 2022/07/16.
//

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
            return "緊急かつ\n重要"
        case .emergencyLowAndImportantHigh:
            return "緊急かつ\n重要"
        case .emergencyLowAndImportantLow:
            return "緊急かつ\n重要"
        }
    }

    func displayString2(hogehoge: Int) -> String {
        switch self {
        case .emergencyHighAndImportantHigh:
            return "緊急かつ\n重要\(hogehoge)"
        case .emergencyHighAndImportantLow:
            return "緊急かつ\n重要\(hogehoge)"
        case .emergencyLowAndImportantHigh:
            return "緊急かつ\n重要\(hogehoge)"
        case .emergencyLowAndImportantLow:
            return "緊急かつ\n重要\(hogehoge)"
        }
    }
}
