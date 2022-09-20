//
//  InputMemoFaile.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/06/26.
//

import SwiftUI
import UIKit

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
            // 背景色をグラデーションする。
            LinearGradient(gradient: Gradient(colors: [.black, .white]),
                           startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 25) {
                HStack {
                    Text("New Task")
                        .font(.system(size: 50, weight: .bold, design: .default))
                        .foregroundColor(Color.orange)
                    Spacer()
                }
                .padding(.horizontal)
                ScrollView {
                    ZStack {
                        VStack {
                            VStack(spacing: -20) {
                                HStack(spacing: 20) {
                                    Text("Task Title")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundColor(Color.black)
                                        .padding()
                                } // Hstackここまで
                                TextField("", text: $inputItem.subject)
                                    .font(.system(.title, design: .rounded))
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 3)
                                            .stroke(Color.black, lineWidth: 3)
                                    )
                                    .frame(width: 290, height: 60)
                                    .textFieldStyle(.roundedBorder)
                            } // Vstackここまで

                            VStack(spacing: -20) {
                                HStack(spacing: 20) {
                                    Text("Task Contents")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundColor(Color.black)
                                        .padding()
                                }
                                // RegistrationViewModelで定義した値を引数に指定する。
                                TextField("", text: $inputItem.content)
                                    .font(.system(.title, design: .rounded))
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 3)
                                            .stroke(Color.black, lineWidth: 3)
                                    )
                                    .frame(width: 290, height: 60)
                                    .textFieldStyle(.roundedBorder)
                                    .padding()
                            }
                        } // Vstackここまで
                    } //  ZStackここまで
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()

                    ZStack {
                        VStack {
                            // RegistrationViewModelで定義した値を引数に指定する。
                            DatePicker("", selection: $inputItem.date, displayedComponents: .date)
                                .datePickerStyle(.graphical)
                                .shadow(radius: 5)

                            Spacer()
                        } // VStackここまで
                    } //  ZStackここまで
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                    // ボタンを押した時に優先順位毎に応じて、Listに登録し表示できるようにする。

                    Capsule()
                        .frame(width: 370, height: 1)
                        .foregroundColor(Color.white)

                    HStack {
                        VStack {
                            HStack {
                                Text("Priority Reset")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(Color.black)
                                    .padding(.horizontal)
                            } // Hstackここまで
                            Picker("", selection: self.$afterPriority) {
                                ForEach(0 ..< priorityList.count, id: \.self) { index in
                                    Text(priorityList[index])
                                        .tag(priorityList[index])
                                } // ForEachここまで
                            } // Pickerここまで
                            .pickerStyle(DefaultPickerStyle())
                            .foregroundColor(Color.black)
                            .shadow(radius: 5)
                        } // VStackここまで
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding(.horizontal)
                        .padding(.top)
                        .padding(.bottom)

                        Spacer()
                        Button(action: {
                            // HomeViewで選択した、優先順位のボタンをタップしたときに受け取る列挙型の値をViewModelのpriority変数に格納する。
                            // RegistrationViewModelで定義した値に引き渡す。
                            //                    inputItem.priority = selectedPriority
                            inputItem.priority = afterPriority
                            inputItem.memoInputText(dismiss: dismiss)
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
        } // ZStackここまで
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
