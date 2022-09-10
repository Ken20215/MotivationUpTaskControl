//
//  EditMemoView.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/07/01.
//

import SwiftUI

struct EditMemoView: View {
    var edititem: Memo
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @StateObject private var editMemoItem = EditMemoViewModel()
    @State private var editContent: String = ""
    @State private var editDate: Date = Date()
    
    var body: some View {
        VStack {
            Spacer()
            Group {
                TextEditor(text: $editMemoItem.content)
                    .edgesIgnoringSafeArea(.all)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .ignoresSafeArea(.keyboard, edges: .all)
                    .padding()
                DatePicker("", selection: $editMemoItem.date, displayedComponents: [.date])
                    .frame(width: 100, height: 100, alignment: .center)
                    .padding()
                    .environment(\.locale, Locale.init(identifier: "en_US"))
            }
            .onAppear(perform: {
                if let uwnrapContent = edititem.content,
                   let uwnrapDate = edititem.date {
                    editMemoItem.content = uwnrapContent
                    editMemoItem.date = uwnrapDate
                }
                try? viewContext.save()
            })
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button( action: {
                    editMemoItem.saveMemo(editItem: edititem,
                                          viewContext: viewContext,
                                          dismiss: dismiss)
                }, label: {
                    Text("DONE")
                })
            }
        }
    }
}
