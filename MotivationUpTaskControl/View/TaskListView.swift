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
    @State var savedItem = SavedView()
    @FetchRequest var items: FetchedResults<Memo>
    @Binding var showEdit: Bool
    @Binding var showItem: Bool
    //    @Binding var arrayPriority2: [ChartEntry]

    var body: some View {
        if items.isEmpty {
            Text("なし")
                .font(.largeTitle)
                // 文字の太さを指定。
                .fontWeight(.black)
                .foregroundColor(Color.orange)
        } else {
            NavigationView {
                List {
                    ForEach(items, id: \.self) { item in
                        NavigationLink(destination: EditMemoView(edititem: item),
                                       isActive: $showEdit,
                                       label: {
                                        Button(action: {
                                            showEdit = true
                                        }) {
                                            VStack(alignment: .leading) {
                                                Text("件名：\(item.subject ?? "")")
                                                    .font(.system(size: 20, weight: .bold, design: .default))
                                                    .italic()
                                                Text("\(item.content ?? "")")
                                                //　CoreDataのAttributeに登録しないといけいのに、個別で一つの登録を行なったため、エラーが発生。
                                                Text(item.date!, style: .date)
                                                    .environment(\.locale, Locale.init(identifier: "en_US"))
                                                    .foregroundColor(.red)
                                            } // Vstackここまで
                                        }
                                       }) // NavigationLinkここまで
                    } // ForEachここまで
                    .onDelete { IndexSet in
                        saveItems.deleteItems(offsets: IndexSet,
                                              items: items)
                        showItem = true
                        print(showItem)
                    } // .onDeleteここまで
                    // 削除対象
                } // Listここまで
                Spacer(minLength: 200)
                    .listStyle(GroupedListStyle())
            } // NavigationViewここまで
        } // if文ここまで
    } // var bodyここまで
} // TaskListViewここまで
