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
    @State var displaySubject: String = ""
    @State var displayContent: String = ""
    @State var displayDate: Date = Date()
    
    var body: some View {
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
                }) // NavigationLinkここまで
            } // ForEachここまで
            .onDelete { IndexSet in
                saveItems.deleteItems(offsets: IndexSet, items: items, viewContext: viewContext)
            } // .onDeleteここまで
            
            .onAppear(perform: {
                for item in items {
                    if let uwnrapSubject = item.subject,
                       let  uwnrapContent = item.content,
                       let uwnrapDate = item.date {
                        displaySubject = uwnrapSubject
                        displayContent = uwnrapContent
                        displayDate = uwnrapDate
                    }
                }
            })
        } // Listここまで
    }
}
