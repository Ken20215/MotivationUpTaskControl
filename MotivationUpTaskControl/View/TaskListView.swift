//
//  TaskListView.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/07/12.
//

import SwiftUI

struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @StateObject private var saveItems = SavedViewModel()
    @FetchRequest var items: FetchedResults<Memo>
    @State private var displaySubject: String = ""
    @State private var displayContent: String = ""
    @State private var displayDate: Date = Date()

    var body: some View {
        if items.isEmpty {
            Text("No Task")
                .font(.largeTitle)
                // 文字の太さを指定。
                .fontWeight(.black)
        } else {
            NavigationView {
                List {
                    ForEach(items, id: \.self) { item in
                        NavigationLink(destination: EditMemoView(edititem: item),
                                       label: {
                                        VStack(alignment: .leading) {
                                            Text("\(displaySubject)")
                                                .font(.system(.largeTitle, design: .monospaced))
                                                .fontWeight(.ultraLight)
                                                .bold()
                                                .italic()
                                            Text("\(displayContent)")
                                            //　CoreDataのAttributeに登録しないといけいのに、個別で一つの登録を行なったため、エラーが発生。
                                            Text(displayDate, style: .date)
                                                .environment(\.locale, Locale.init(identifier: "en_US"))
                                                .foregroundColor(.red)
                                        } // Vstackここまで
                                        .padding(.bottom)
                                       }) // NavigationLinkここまで
                    } // ForEachここまで

                    .onDelete { IndexSet in
                        saveItems.deleteItems(offsets: IndexSet,
                                              items: items,
                                              viewContext: viewContext)
                    } // .onDeleteここまで

                    .onAppear(perform: {
                        for item in items {
                            if let uwnrapSubject = item.subject,
                               let uwnrapContent = item.content,
                               let uwnrapDate = item.date {
                                displaySubject = uwnrapSubject
                                displayContent = uwnrapContent
                                displayDate = uwnrapDate
                            }
                        } // for文ここまで
                    }) // .onApperここまで
                } // Listここまで
                Spacer(minLength: 200)
                    .listStyle(GroupedListStyle())
            } // NavigationViewここまで
        } // if文ここまで
    } // var bodyここまで
} // TaskListViewここまで
