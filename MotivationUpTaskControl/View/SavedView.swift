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
    @State var index = 0

    var body: some View {
        Group {
            VStack(spacing: 25) {
                HStack {
                    Text("List一覧")
                        // 太文字に変更
                        .fontWeight(.bold)
                        // 文字サイズを変更
                        .font(.title)
                    Spacer()
                }
                .padding(.horizontal)
                ScrollView(.horizontal) {
                    HStack {
                        Button(action: {
                            priorityCategory = PriorityEnum.emergencyHighAndImportantHigh.rawValue
                            self.index = 0
                        }) {
                            Text("\(PriorityEnum.emergencyHighAndImportantHigh.rawValue)")
                                .fontWeight(self.index == 0 ? .bold : .none)
                                .foregroundColor(Color.white)
                                .padding()
                                .background {
                                    Capsule()
                                        // 影を装飾
                                        .shadow(radius: 4)
                                        .opacity(self.index == 0 ? 1 : 0.4)
                                } // backgroundここまで
                        }

                        Button(action: {
                            priorityCategory = PriorityEnum.emergencyHighAndImportantLow.rawValue
                            self.index = 1
                        }) {
                            Text("\(PriorityEnum.emergencyHighAndImportantLow.rawValue)")
                                .fontWeight(self.index == 1 ? .bold : .none)
                                .foregroundColor(Color.white)
                                .padding()
                                .background {
                                    Capsule()
                                        // 影を装飾
                                        .shadow(radius: 4)
                                        .opacity(self.index == 1 ? 1 : 0.4)
                                } // backgroundここまで
                        }

                        Button(action: {
                            priorityCategory =  PriorityEnum.emergencyLowAndImportantLow.rawValue
                            self.index = 2
                        }) {
                            Text("\( PriorityEnum.emergencyLowAndImportantLow.rawValue)")
                                .fontWeight(self.index == 2 ? .bold : .none)
                                .foregroundColor(Color.white)
                                .padding()
                                .background {
                                    Capsule()
                                        // 影を装飾
                                        .shadow(radius: 4)
                                        .opacity(self.index == 2 ? 1 : 0.4)
                                } // backgroundここまで
                        }

                        Button(action: {
                            priorityCategory =  PriorityEnum.emergencyLowAndImportantHigh.rawValue
                            self.index = 3
                        }) {
                            Text("\(PriorityEnum.emergencyLowAndImportantHigh.rawValue)")
                                .fontWeight(self.index == 3 ? .bold : .none)
                                .foregroundColor(Color.white)
                                .padding()
                                .background {
                                    Capsule()
                                        // 影を装飾
                                        .shadow(radius: 4)
                                        .opacity(self.index == 3 ? 1 : 0.4)
                                } // backgroundここまで
                        }

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
