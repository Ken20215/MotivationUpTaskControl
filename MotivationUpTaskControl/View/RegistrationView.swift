//
//  InputMemoFaile.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/06/26.
//

import SwiftUI

struct RegistrationView: View {
    // CoreDataの登録する所まで情報をもらう為、＠Bindingを使って画面間で受け渡しする。
    // @Stateを使用すると、状態変数の値が変えてから画面遷移しても初期値のままなので＠Bindingを使用している。
    // @StateはselectedPriorityの値が初期状態のままでファイル間で受け渡ししてしまうため @Bindingであれそのままの状態で参照渡しできる。
    @Binding var selectedPriority: PriorityEnum
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @StateObject private var inputItem = RegistrationViewModel()
    @State private var inputText: String = ""
    @State private var flag = false
    @State private var priority: String = "高"
    var priorityList: [String] = ["高", "中", "低"]

    var body: some View {
        VStack {
            ScrollView {
                Group {
                    Spacer()
                    TextField("件名", text: $inputText)
                        .frame(width: 290, height: 60)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .border(Color.gray, width: 3)

                    Spacer()

                    Toggle(isOn: $flag) {
                        Text(flag ? "完了" : "未完了")
                    } // Toggleここまで
                    .frame(width: 290, height: 60)
                    .padding()
                    .border(Color.gray, width: 3)

                    Spacer()
                    HStack {
                        Text("優先度")
                            .padding()

                        Picker("", selection: self.$priority) {
                            ForEach(0 ..< priorityList.count, id: \.self) { index in
                                Text(priorityList[index])
                                    .tag(priorityList[index])
                            }
                        } // Pickerここまで
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 200, height: 60)
                        .padding()
                    } // Hstackここまで
                    .border(Color.gray, width: 3)
                    Spacer()
                    // RegistrationViewModelで定義した値を引数に指定する。
                    DatePicker("期日", selection: $inputItem.date)
                        .frame(width: 290, height: 60)
                        .padding()
                        .border(Color.gray, width: 3)
                    Spacer()
                    // RegistrationViewModelで定義した値を引数に指定する。
                    TextEditor(text: $inputItem.content)
                        .frame(width: 315, height: 250)
                        // TextEditorのボーダーカラーをグレーに指定し、ボーダー線の太さを指定。
                        .border(Color.gray, width: 3)
                        .padding()
                } // Groupここまで
                // ボタンを押した時に優先順位毎に応じて、Listに登録し表示できるようにする。
                Button(action: {
                    // HomeViewで選択した、優先順位のボタンをタップしたときに受け取る列挙型の値をViewModelのpriority変数に格納する。
                    // RegistrationViewModelで定義した値に引き渡す。
                    inputItem.priority = selectedPriority
                    inputItem.memoInputText(viewContext: viewContext, dismiss: dismiss)
                }) {
                    Text("保存")
                        .frame(width: 290, height: 60)
                        .padding()
                        .border(Color.gray, width: 3)
                }
                Spacer()
            } // ScrollViewここまで
        } // VStackここまで
    } // var bodyここまで
} // InputMemoFaileここまで

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        // selectedPriorityを初期化する。
        RegistrationView(selectedPriority: .constant(.emergencyHighAndImportantHigh))
    }
}
