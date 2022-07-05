//
//  InputMemoFaile.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/06/26.
//

import SwiftUI
import CoreData

struct Registration: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @StateObject private var inputItem = RegistrationViewModel()
    @State private var inputText: String = ""
    @State private var flag = false
    @State private var priority: String = "高"
    private var priorityList: [String] = ["高", "中", "低"]
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

                    DatePicker("期日", selection: $inputItem.date)
                        .frame(width: 290, height: 60)
                        .padding()
                        .border(Color.gray, width: 3)
                    Spacer()
                    TextEditor(text: $inputItem.content)
                        .frame(width: 315, height: 250)
                        // TextEditorのボーダーカラーをグレーに指定し、ボーダー線の太さを指定。
                        .border(Color.gray, width: 3)
                        .padding()
                } // Groupここまで
                Button(action: {
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

struct InputMemoFaile_Previews: PreviewProvider {
    static var previews: some View {
        Registration()
    }
}
