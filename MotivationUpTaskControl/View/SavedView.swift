//
//  SaveView.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/06/26.
//

import SwiftUI
import CoreGraphics

struct SavedView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @StateObject private var saveItems = SavedViewModel()
    // PriorityModelViewで定義した列挙値をrawValueを使用し、String型で表示できるように指示する。
    @State private var prioritys: [String] = [
        PriorityEnum.emergencyHighAndImportantHigh.rawValue,
        PriorityEnum.emergencyHighAndImportantLow.rawValue,
        PriorityEnum.emergencyLowAndImportantLow.rawValue,
        PriorityEnum.emergencyLowAndImportantHigh.rawValue
    ]
    @State private var priorityCategory = PriorityEnum.emergencyHighAndImportantHigh.rawValue

    var body: some View {
        Group {
            VStack(spacing: 25) {
                HStack {
                    Text("List一覧")
                        // 太文字に変更
                        .fontWeight(.bold)
                        // 文字サイズを変更
                        .font(.title)
                }
                .padding()
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<prioritys.count, id: \.self) { item in
                            Button(action: {
                                priorityCategory = prioritys[item]
                            }) {
                                Text(self.prioritys[item])
                                    .font(.callout)
                                    .foregroundColor(Color.white)
                                    .padding()
                            } // Buttonここまで
                            .background {
                                Capsule()
                                    // 影を装飾
                                    .shadow(radius: 4)
                                    .opacity(0.4)
                            } // backgroundここまで

                        } // ForEachここまで
                    } // Hstackここまで
                } //  ScrollViewここまで
                .padding(.horizontal)

                Spacer()
                TaskListView(items: FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Memo.date, ascending: true)],
                                                 predicate: NSPredicate(format: "priority == %@", priorityCategory),
                                                 animation: .default))
                Spacer()
            } //  VStackここまで
        } // Groopここまで
    } // var bodyここまで
} // SaveViewここまで

struct SaveView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
    }
}
