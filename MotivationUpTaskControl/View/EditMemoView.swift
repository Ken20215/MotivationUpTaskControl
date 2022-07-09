//
//  EditMemoView.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/07/01.
//

import SwiftUI
import CoreData

struct EditMemoView: View {
    var edititem: Memo
    @StateObject private var editMemoItem = EditMemoViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
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
                editMemoItem.content = edititem.content1 ?? ""
                editMemoItem.date = edititem.date1!
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
                    Text("Edit")
                })
            }
        }
    }
}
