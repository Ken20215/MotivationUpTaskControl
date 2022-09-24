//
//  InputMemoFaileViewModel.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/07/01.
//

import SwiftUI
import CoreData

class RegistrationViewModel: ObservableObject {
    let viewContext = PersistenceController.shared.container.viewContext
    @Published var subject = ""
    @Published var content = ""
    @Published var date = Date()
    @Published var priority = ""

    func memoInputText(dismiss: DismissAction) {
        // 保存するCoreDataのMemo型インスタンス変数を作成・初期化する。
        // CoreDataに格納するタイミングは、全てのCoreDataに登録する値が揃ったタイミングで登録を行う。
        // 他のファイルなど別々に登録を行わないこと。
        let inputItem = Memo(context: viewContext)
        inputItem.subject = subject
        inputItem.content = content
        inputItem.date = date
        // CoreDataにRegistrationViewから受け取った値をrpwValueでStringに変換す格納する。
        // inputItem.priority =  priority.rawValue
        inputItem.priority = priority
        // 「try? viewContext.save()」でデータを保存する。
        try? viewContext.save()
        // 画面を閉じる
        dismiss()
    }
}
