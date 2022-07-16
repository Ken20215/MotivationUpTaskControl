//
//  TaskListView.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/07/12.
//

import SwiftUI
import CoreData

struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @StateObject private var saveItems = SavedViewModel()
    @FetchRequest var items: FetchedResults<Memo>

    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                NavigationLink(destination: EditMemoView(edititem: item),
                               label: {
                                VStack(alignment: .leading) {
                                    Text("\(item.content ?? "")")
                                        //                                    Text(item.date!, style: .date)
                                        .environment(\.locale, Locale.init(identifier: "en_US"))
                                } // Vstackここまで
                               }) // NavigationLinkここまで
            } // ForEachここまで
            .onDelete { IndexSet in
                saveItems.deleteItems(offsets: IndexSet, items: items, viewContext: viewContext)
            } // .onDeleteここまで
        } // Listここまで
    }
}
