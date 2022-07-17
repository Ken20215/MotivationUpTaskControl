//
//  SaveView.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/06/26.
//

import SwiftUI

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
    init() {
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.font: UIFont.systemFont(ofSize: 6)], for: .selected)
    }

    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: self.$priorityCategory) {
                    ForEach(0..<prioritys.count, id: \.self) {
                        Text(self.prioritys[$0])
                            .tag(prioritys[$0])
                    } // ForEachここまで
                } // Pickerここまで
                .labelsHidden()
                .pickerStyle(WheelPickerStyle())
                .frame(width: 320, height: 60)

                TaskListView(items: FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Memo.date, ascending: true)],
                                                 predicate: NSPredicate(format: "priority == %@", priorityCategory),
                                                 animation: .default))
            } //  VStackここまで
        } // NavigationViewここまで
    } // var bodyここまで
} // SaveViewここまで

struct SaveView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
    }
}
