//
//  AddSaveViewModel.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/06/30.
//

import SwiftUI
import CoreData

class AddSaveViewModel: ObservableObject {

    func deleteItems(offsets: IndexSet, items: FetchedResults<Memo>, viewContext: NSManagedObjectContext) {
        for index in offsets {
            viewContext.delete(items[index])
        }
        try? viewContext.save()
    }
}
