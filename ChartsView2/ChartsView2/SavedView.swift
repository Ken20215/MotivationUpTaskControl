//
//  ChartsSampleView.swift
//  ChartsView2
//
//  Created by 石岡　顕 on 2022/09/21.
//

import SwiftUI
import Foundation
import Charts

struct SavedView: View {
    let chartsData: [ChartEntry] = [
        ChartEntry(priority: PriorityEnum.emergencyHighAndImportantLow.rawValue, count: 1),
        ChartEntry(priority: PriorityEnum.emergencyLowAndImportantHigh.rawValue, count: 1),
        ChartEntry(priority: PriorityEnum.emergencyLowAndImportantLow.rawValue, count: 1),
        ChartEntry(priority: PriorityEnum.emergencyHighAndImportantHigh.rawValue, count: 1)
    ]
    var body: some View {
        Chart(chartsData) { item in
            BarMark(
                x: .value("Count", item.count)
            )
            .foregroundStyle(by: .value("Category", item.priority))
        }
        .frame(width: 350, height: 100)
        .padding()
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
    }
}

struct ChartEntry: Identifiable {
    var id = UUID()
    let priority: String
    let count: Int
}

enum PriorityEnum: String, CaseIterable {
    case emergencyHighAndImportantHigh = "緊急かつ重要"   // 緊急かつ重要
    case emergencyHighAndImportantLow =  "緊急かつ重要ではない"   // 緊急かつ重要ではない
    case emergencyLowAndImportantHigh = "緊急ではないが、重要"    // 緊急ではないが、重要
    case emergencyLowAndImportantLow  = "緊急ではないが、重要ではない"  // 緊急ではないが、重要ではない
}
