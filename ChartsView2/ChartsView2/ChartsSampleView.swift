//
//  ChartsSampleView.swift
//  ChartsView2
//
//  Created by 石岡　顕 on 2022/09/21.
//

import SwiftUI
import Charts


struct profit2: View {
    let data: [Profit] = [
        Profit(id: "Production", profit: 15000),
        Profit(id: "Marketing", profit: 8000),
        Profit(id: "Finance", profit: 10000)
    ]
    var body: some View {
        Chart(data) {
            BarMark(
                x: .value("Department", $0.profit)
            )
            .foregroundStyle(by: .value("Product Category", $0.id))
        }
        .frame(width: 350, height: 100)
        .padding()
    }
}


struct ChartsSampleView_Previews: PreviewProvider {
    static var previews: some View {
        profit2()
    }
}


struct Profit: Identifiable {
    var id: String
    let profit: Double
}
