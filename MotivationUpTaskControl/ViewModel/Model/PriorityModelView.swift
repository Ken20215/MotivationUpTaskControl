//
//  PriorityModelView.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/07/16.
//

import SwiftUI

// 列挙型で優先順位を決める値を定義。
enum PriorityEnum: String {
    case emergencyHighAndImportantHigh = "緊急かつ重要"   // 緊急かつ重要
    case emergencyHighAndImportantLow =  "緊急かつ重要ではない"   // 緊急かつ重要ではない
    case emergencyLowAndImportantHigh = "緊急ではないが、重要"    // 緊急ではないが、重要
    case emergencyLowAndImportantLow  = "緊急ではないが、重要ではない"  // 緊急ではないが、重要ではない
    
    // switch文でselfを指定。selfは自身を示すため、上のcaseで定義した値でいずれかを指定し呼び出し元で呼び出した際に、
    // 下記の値を呼び出すことができる。今回のパターンはHomeViewで優先順位を示すTextの文字を定義している。
    // 目的は色々な場所で同様の文字を使用するため、他の画面でも統一できるようにすることが目的。
    var displayString: String {
        switch self {
        case .emergencyHighAndImportantHigh:
            return "緊急かつ\n重要"
        case .emergencyHighAndImportantLow:
            return "緊急かつ重要ではない"
        case .emergencyLowAndImportantHigh:
            return "緊急ではないが、重要"
        case .emergencyLowAndImportantLow:
            return "緊急ではないが、重要ではない"
        } // switchここまで
    } // displayStringここまで
} // PriorityEnumここまで
