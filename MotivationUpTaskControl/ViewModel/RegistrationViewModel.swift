//
//  InputMemoFaileViewModel.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/07/01.
//

import SwiftUI

class RegistrationViewModel: ObservableObject {
    @Published var content = ""
    @Published var date = Date()
    // 列挙型のインスタンス変数を作り、インスタンス化を行う。
    var priority: PriorityEnum = .emergencyHighAndImportantHigh

    func memoInputText(viewContext: NSManagedObjectContext, dismiss: DismissAction) {
        // 保存するCoreDataのMemo型インスタンス変数を作成・初期化する。
        // CoreDataに格納するタイミングは、全てのCoreDataに登録する値が揃ったタイミングで登録を行う。
        // 他のファイルなど別々に登録を行わないこと。
        let inputItem = Memo(context: viewContext)
        inputItem.content = content
        inputItem.date = date
        // CoreDataにRegistrationViewから受け取った値をrpwValueでStringに変換す格納する。
        inputItem.priority =  priority.rawValue
        // 「try? viewContext.save()」でデータを保存する。
        try? viewContext.save()
        // 画面を閉じる
        dismiss()
    }
}
