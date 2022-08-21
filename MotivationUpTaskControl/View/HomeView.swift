//
//  HomeView.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/06/26.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) private var presentationMode
    @State private var isShowTap: Bool = false
    // PriorityModelViewの列挙型の値をインスタンス変数に初期化してあげる。
    @State private var tapPriority: PriorityEnum = .emergencyHighAndImportantHigh
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        // 優先を決めるボタンをタップしたら、指定の優先順位の文字が入ってい列挙型の値「emergencyHighAndImportantHigh」を代入する。
                        tapPriority = .emergencyHighAndImportantHigh
                        isShowTap.toggle()
                    }) {
                        // 緊急かつ重要
                        // PriorityViewModelで定義した格納型変数をインスタンスし呼び出す。
                        Text(PriorityEnum.emergencyHighAndImportantHigh.displayString)
                            .frame(width: 130, height: 130)
                            .foregroundColor(Color.white)
                            .background(Color.red)
                            .sheet(isPresented: $isShowTap) {
                                RegistrationView(selectedPriority: $tapPriority)
                            }
                    } // 「緊急かつ重要」Buttonここまで

                    Button(action: {
                        // 優先を決めるボタンをタップしたら、指定の優先順位の文字が入ってい列挙型の値「.emergencyHighAndImportantLow」を代入する。
                        tapPriority = .emergencyHighAndImportantLow
                        isShowTap.toggle()
                    }) {
                        // 緊急だが重要でない
                        // PriorityViewModelで定義した格納型変数をインスタンスし呼び出す。
                        Text(PriorityEnum.emergencyHighAndImportantLow.displayString)
                            .frame(width: 130, height: 130)
                            .foregroundColor(Color.white)
                            .background(Color.yellow)
                            .sheet(isPresented: $isShowTap) {
                                RegistrationView(selectedPriority: $tapPriority)
                            }
                    } // 「緊急だが重要でない」Buttonここまで
                } // Hstackここまで
                HStack {
                    Button(action: {
                        // 優先を決めるボタンをタップしたら、指定の優先順位の文字が入ってい列挙型の値「.emergencyLowAndImportantHigh」を代入する。
                        tapPriority = .emergencyLowAndImportantHigh
                        isShowTap.toggle()
                    }) {
                        // 緊急でないが重要
                        // PriorityViewModelで定義した格納型変数をインスタンスし呼び出す。
                        Text(PriorityEnum.emergencyLowAndImportantHigh.displayString)
                            .frame(width: 130, height: 130)
                            .foregroundColor(Color.white)
                            .background(Color.green)
                            .sheet(isPresented: $isShowTap) {
                                RegistrationView(selectedPriority: $tapPriority)
                            }
                    } // 「緊急でないが重要」Buttonここまで

                    Button(action: {
                        // 優先を決めるボタンをタップしたら、指定の優先順位の文字が入ってい列挙型の値「.emergencyLowAndImportantLow」を代入する。
                        tapPriority = .emergencyLowAndImportantLow
                        isShowTap.toggle()
                    }) {
                        //　緊急でなく重要でない
                        // PriorityViewModelで定義した格納型変数をインスタンスし呼び出す。
                        Text(PriorityEnum.emergencyLowAndImportantLow.displayString)
                            .frame(width: 130, height: 130)
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .sheet(isPresented: $isShowTap) {
                                RegistrationView(selectedPriority: $tapPriority)
                            }
                    } // 「緊急でなく重要でない」Buttonここまで
                } // Hstackここまで
                Spacer()
            } // Vstackここまで
            .navigationBarTitle("Task")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
