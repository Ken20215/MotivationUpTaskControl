//
//  SaveView.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/06/26.
//

import SwiftUI
import CoreData

struct SaveView: View {
    @StateObject private var saveItems = AddSaveViewModel()
    @State private var prioritys: [String] = ["緊急かつ重要", "緊急だが重要でない", "緊急でないが重要", "緊急でなく重要でない"]
    @State private var priorityCategory: Int = 0
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Memo.date, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Memo>

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
                    }
                } // Pickerここまで
                .labelsHidden()
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 320, height: 60)

                List() {
                    ForEach(items) { item in
                        NavigationLink(destination: EditMemoView(edititem: item),
                                       label: {
                                        VStack(alignment: .leading) {
                                            Text("\(item.content ?? "")")
                                            Text(item.date!, style: .date)
                                                .environment(\.locale, Locale.init(identifier: "en_US"))
                                        } // Vstackここまで
                                       }) // NavigationLinkここまで
                    } // ForEachここまで
                    .onDelete { IndexSet in
                        saveItems.deleteItems(offsets: IndexSet, items: items, viewContext: viewContext)
                    }
                } // Listここまで
            } //  VStackここまで
        } // NavigationViewここまで
    } // var bodyここまで
} // SaveViewここまで

struct SaveView_Previews: PreviewProvider {
    static var previews: some View {
        SaveView()
    }
}
