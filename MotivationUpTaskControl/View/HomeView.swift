//
//  HomeView.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/06/26.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    @State var isShowTap: Bool = false
    // PriorityModelViewの列挙型の値をインスタンス変数に初期化してあげる。
    @State var tapPriority: PriorityEnum = .emergencyHighAndImportantHigh

    var body: some View {
        NavigationView {
            // もしisShowtapがfalseであれば画面をそのままの状態にし、trueであれば画面をNavigationLink先に遷移させ、HomeView画面を閉じる。
            if isShowTap == false {
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
                            } // 「緊急でなく重要でない」Buttonここまで
                        } // Hstackここまで
                        Spacer()
                    } // Vstackここまで
                    .navigationBarTitle("Task")
                } // Zstackここまで
            } else {
                // 引数（isActive）に画面遷移の条件となるフラグ（Bool型のバインド変数）を指定します。
                // このフラグがtrueになった時に画面遷移します。
                // 画面遷移するタイミングでRegistrationViewのselectedPriorityにタップした優先順位を示す
                // 列挙型の値「tapPriority」を格納し、メモ登録画面に遷移する。
                NavigationLink(destination: RegistrationView(selectedPriority: $tapPriority),
                               isActive: $isShowTap) {
                    // ラベルに EmptyView() を指定して「ラベルViewを表示しない」ようにすると、タップによる遷移を排除可能です。
                    EmptyView()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                            isShowTap.toggle()
                        }) {
                        }
                    }
                }
            }
        } //  NavigationViewここまで
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
