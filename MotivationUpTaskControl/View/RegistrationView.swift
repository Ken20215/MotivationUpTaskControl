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
    @State private var priorityList: [String] = [
        PriorityEnum.emergencyHighAndImportantHigh.rawValue,
        PriorityEnum.emergencyHighAndImportantLow.rawValue,
        PriorityEnum.emergencyLowAndImportantLow.rawValue,
        PriorityEnum.emergencyLowAndImportantHigh.rawValue
    ]
    @State private var afterPriority = ""

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 25) {
                Spacer()
                HStack {
                    Text("Registration")
                        .font(.title)
                        .foregroundColor(Color.white)
                      Spacer()
                }
                ScrollView {
                    ZStack {
                        VStack {
                            VStack(spacing: -20) {
                                HStack(spacing: 20) {
                                    Text("Task title")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundColor(Color.gray)
                                        .padding()
                                } // Hstackここまで
                                TextField("", text: $inputItem.subject)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: 270, height: 60)
                                    .textFieldStyle(.roundedBorder)
                                    .shadow(radius: 3)

                                    // 色をAssetsで指定すること。
                                    .border(Color.white, width: 3)
                            } // Vstackここまで

                            VStack(spacing: -20) {
                                HStack(spacing: 20) {
                                    Text("Task Contents")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundColor(Color.gray)
                                        .padding()
                                }
                                // RegistrationViewModelで定義した値を引数に指定する。
                                TextField("", text: $inputItem.content)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: 270, height: 60)
                                    .textFieldStyle(.roundedBorder)
                                    .shadow(radius: 3)
                                    // 色をAssetsで指定すること。
                                    .border(Color.white, width: 3)
                                    .padding()
                            }
                        } // Vstackここまで
                    } //  ZStackここまで
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()

                    Capsule()
                        .frame(width: 330, height: 1)
                        .foregroundColor(Color.white)

                    ZStack {
                        VStack {
                            HStack {
                                Text("優先度")
                                    .padding()

                                Picker("", selection: self.$afterPriority) {
                                    ForEach(0 ..< priorityList.count, id: \.self) { index in
                                        Text(priorityList[index])
                                            .tag(priorityList[index])
                                    }
                                } // Pickerここまで
                                .pickerStyle(DefaultPickerStyle())
                                .foregroundColor(Color.black)
                                .frame(width: 200, height: 60)
                                .shadow(radius: 5)
                            } // Hstackここまで
                            // RegistrationViewModelで定義した値を引数に指定する。
                            DatePicker("期日", selection: $inputItem.date)
                                .frame(width: 270, height: 60)
                                .shadow(radius: 5)

                            Spacer()
                        } // VStackここまで
                    } //  ZStackここまで
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                    // ボタンを押した時に優先順位毎に応じて、Listに登録し表示できるようにする。
                    HStack {
                        Spacer()
                        Button(action: {
                            // HomeViewで選択した、優先順位のボタンをタップしたときに受け取る列挙型の値をViewModelのpriority変数に格納する。
                            // RegistrationViewModelで定義した値に引き渡す。
                            //                    inputItem.priority = selectedPriority
                            inputItem.priority = afterPriority
                            inputItem.memoInputText(viewContext: viewContext, dismiss: dismiss)
                        }) {
                            ZStack {
                                Circle()
                                    .background(Color.blue)
                                    .frame(width: 60, height: 60, alignment: .leading)
                                    .cornerRadius(50)
                                    .padding()
                                Image(systemName: "plus")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30))

                            } // Zstackここまで
                        } // Buttonここまで
                    } // Hstackここまで
                } // ScrollViewここまで
            } // VStackここまで
        }
        .onAppear(perform: {
            afterPriority = selectedPriority.rawValue
        })
    } // var bodyここまで
} // InputMemoFaileここまで

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        // selectedPriorityを初期化する。
        RegistrationView(selectedPriority: .constant(.emergencyHighAndImportantHigh))
    }
}
