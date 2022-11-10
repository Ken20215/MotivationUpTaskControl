//
//  SaveView.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/06/26.
//

import SwiftUI
import Charts

struct ChartEntry: Identifiable {
    // 達成度と優先度毎のタスク登録数
    let id = UUID()
    var priority: String
    var count: Int
}

struct SavedView: View {
    // CoreDataから値を探してもらう。値を探して見つけた値をFetchedResults<Memo>型のitemsに格納する。
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Memo.date, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Memo>
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
    @State private var index: Int = 0
    @State private var showEdit: Bool = false
    @State private var showItem: Bool = false
    @State private var arrayPriority: [ChartEntry] = []
    @State private var newArrayPriority: [ChartEntry] = []

    var body: some View {
        Group {
            VStack {
                if showEdit == false {
                    VStack {
                        // showがtrueであればText（Tasks）を表示させる。
                        HStack {
                            Text("タスク一覧")
                                // 文字サイズを変更
                                .font(.system(size: 45, weight: .bold, design: .default))
                                .foregroundColor(Color.orange)
                            Spacer()
                        } //  HStackここまで
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
                                                .opacity(self.index == 0 ? 1 : 0.2)
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
                                                .opacity(self.index == 1 ? 1 : 0.2)
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
                                                .opacity(self.index == 2 ? 1 : 0.2)
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
                                                .opacity(self.index == 3 ? 1 : 0.2)
                                        } // backgroundここまで
                                }
                                .padding()
                            } // Hstackここまで
                        } //  ScrollViewここまで
                    } // Vstackここまで
                    .edgesIgnoringSafeArea(.top)
                    .edgesIgnoringSafeArea(.horizontal)
                    .padding(.top)
                    .padding(.horizontal)
                    .background(Color.black)
                }
                AnimatedChart()
                Spacer()
                // 編集画面が表示される際に、上のText「Tasks」と優先度を決めるボタンの表示を無くしたい。
                TaskListView(items: FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Memo.date, ascending: true)],
                                                 predicate: NSPredicate(format: "priority == %@", priorityCategory),
                                                 animation: .default), showEdit: $showEdit,
                             showItem: $showItem)
                Spacer()
            } //  VStackここまで
            .onAppear(perform: {
                arrayPriority.append(contentsOf: selectPriority(items: items))
                newArrayPriority.append(contentsOf: totalArrayPriority(arrayPriority: arrayPriority))
            })
            .onChange(of: showItem, perform: { item in
                if item == true {
                    arrayPriority.append(contentsOf: selectPriority(items: items))
                    newArrayPriority.append(contentsOf: totalArrayPriority(arrayPriority: arrayPriority))
                    self.showItem = false
                }
            })
        } // Groopここまで
    } // var bodyここまで

    //  横棒一つにする（帯グラフにする）
    //  x軸は達成度にする。y軸を各優先度のタスクの数（Int型）。
    @ViewBuilder
    func AnimatedChart() -> some View {
        Chart {
            ForEach(newArrayPriority) { item in
                BarMark(
                    x: .value("Count", item.count)
                )
                .foregroundStyle(by: .value("Category", item.priority))
            }
        }
        .chartForegroundStyleScale([
            PriorityEnum.emergencyHighAndImportantLow.rawValue: .yellow,
            PriorityEnum.emergencyLowAndImportantLow.rawValue: .blue,
            PriorityEnum.emergencyLowAndImportantHigh.rawValue: .green,
            PriorityEnum.emergencyHighAndImportantHigh.rawValue: .red
        ])
        .frame(height: 90)
        .padding(.top)
        .padding(.horizontal)
    }

    // タスクの明細
    private func selectPriority(items: FetchedResults<Memo>) -> [ChartEntry] {
        arrayPriority.removeAll()
        var priorityList: [ChartEntry] = []
        for item in items {
            if item.priority == PriorityEnum.emergencyHighAndImportantHigh.rawValue {
                priorityList.append(ChartEntry(priority: PriorityEnum.emergencyHighAndImportantHigh.rawValue,
                                               count: 1))
            } else if item.priority == PriorityEnum.emergencyHighAndImportantLow.rawValue {
                priorityList.append(ChartEntry(priority: PriorityEnum.emergencyHighAndImportantLow.rawValue,
                                               count: 1))
            } else if item.priority == PriorityEnum.emergencyLowAndImportantHigh.rawValue {
                priorityList.append(ChartEntry(priority: PriorityEnum.emergencyLowAndImportantHigh.rawValue,
                                               count: 1))
            } else {
                priorityList.append(ChartEntry(priority: PriorityEnum.emergencyLowAndImportantLow.rawValue,
                                               count: 1))
            }
        }
        return priorityList
    } // selectPriorityここまで

    private func totalArrayPriority(arrayPriority: [ChartEntry]) -> [ChartEntry] {
        newArrayPriority.removeAll()
        var newPriorityList: [ChartEntry] = []
        var jugEmergencyHighAndImportantLow: Bool = false
        var jugEmergencyLowAndImportantHigh: Bool = false
        var jugEmergencyLowAndImportantLow: Bool = false

        for item in arrayPriority {
            if item.priority == PriorityEnum.emergencyHighAndImportantHigh.rawValue {
                newArrayPriority.append(ChartEntry(priority: PriorityEnum.emergencyHighAndImportantHigh.rawValue,
                                                   count: 1))
            } else {
                jugEmergencyHighAndImportantLow = true
            }
        }
        if jugEmergencyHighAndImportantLow == true {
            for item in arrayPriority {
                if item.priority == PriorityEnum.emergencyHighAndImportantLow.rawValue {
                    newArrayPriority.append(ChartEntry(priority: PriorityEnum.emergencyHighAndImportantLow.rawValue,
                                                       count: 1))
                } else {
                    jugEmergencyLowAndImportantHigh = true
                }
            }
        }
        if jugEmergencyLowAndImportantHigh == true {
            for item in arrayPriority {
                if item.priority == PriorityEnum.emergencyLowAndImportantHigh.rawValue {
                    newArrayPriority.append(ChartEntry(priority: PriorityEnum.emergencyLowAndImportantHigh.rawValue,
                                                       count: 1))
                } else {
                    jugEmergencyLowAndImportantLow = true
                }
            }
        }
        if jugEmergencyLowAndImportantLow == true {
            for item in arrayPriority {
                if item.priority == PriorityEnum.emergencyLowAndImportantLow.rawValue {
                    newPriorityList.append(ChartEntry(priority: PriorityEnum.emergencyLowAndImportantLow.rawValue,
                                                      count: 1))
                }
            }
        }
        return newPriorityList
    }
} // SaveViewここまで

struct SaveView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
    }
}
