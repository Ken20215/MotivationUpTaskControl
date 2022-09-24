//
//  AddSaveViewModel.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/06/30.
//

import SwiftUI
import CoreData

class SavedViewModel: ObservableObject {
    let viewContext = PersistenceController.shared.container.viewContext

    func deleteItems(offsets: IndexSet, items: FetchedResults<Memo>) {
        for index in offsets {
            viewContext.delete(items[index])
        }
        try? viewContext.save()
    }
}
