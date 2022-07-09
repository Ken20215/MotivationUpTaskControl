//
//  EditViewModel.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/07/01.
//

import SwiftUI
import CoreData

class EditMemoViewModel: ObservableObject {
    @Published var content = ""
    @Published var date = Date()

    func saveMemo(editItem: Memo, viewContext: NSManagedObjectContext, dismiss: DismissAction) {
        editItem.content1 = content
        editItem.date1 = date
        try? viewContext.save()
        dismiss()
    }

}
