//
//  InputMemoFaileViewModel.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/07/01.
//

import SwiftUI
import CoreData

class InputMemoFaileViewModel: ObservableObject {
    @Published var content = ""
    @Published var date = Date()

    func memoInputText(viewContext: NSManagedObjectContext, dismiss: DismissAction) {
        // 保存するCoreDataのMemo型インスタンス変数を作成・初期化する。
        let inputItem = Memo(context: viewContext)
        inputItem.content = content
        inputItem.date = date
        // Memo型のインスタンス変数のinputItemに文字と日付を入れて
        // 「try? viewContext.save()」でデータを保存する。
        try? viewContext.save()
        // 画面を閉じる
        dismiss()
    }
}
