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
    let data: [ChartEntry] = [
      ChartEntry(priority: "緊急かつ重要ではない", count: 1),
      ChartEntry(priority: "緊急ではないが、重要", count: 1),
      ChartEntry(priority: "緊急ではないが、重要ではない", count: 1),
      ChartEntry(priority: "緊急かつ重要", count: 1)
    ]
    var body: some View {
        Chart(data) {
            BarMark(
                x: .value("Count", $0.count)
            )
            .foregroundStyle(by: .value("Category", $0.priority))
        }
        .frame(width: 350, height: 100)
        .padding()
    }
}


struct ChartsSampleView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
    }
}


struct ChartEntry: Identifiable {
    var id = UUID()
    let priority: String
    let count: Int
}
