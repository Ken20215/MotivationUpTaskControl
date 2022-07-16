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
    @State var selectedPriority: PriorityEnum = .emergencyLowAndImportantHigh

    // 各優先度の押したボタンに従ってタスクメモを登録する。
    // 列挙型で管理するには押したボタンに沿ってメモを登録する。列挙体に中に優先度を定義して、その中にString型とDate型の値を入れる関数を作成。
    // ボタンタップで優先度を選ぶようにする。

    let priority: PriorityEnum = .emergencyHighAndImportantHigh

    var body: some View {
        NavigationView {
            // もしisShowtapがfalseであれば画面をそのままの状態にし、trueであれば画面をNavigationLink先に遷移させ、HomeView画面を閉じる。
            if isShowTap == false {
                ZStack {
                    VStack {
                        Spacer()
                        HStack {
                            Button(action: {
                                selectedPriority = .emergencyHighAndImportantHigh
                                isShowTap.toggle()
                            }) {
                                // 緊急かつ重要
                                // urgent and vital
                                Text(PriorityEnum.emergencyHighAndImportantHigh.displayString)
                                    .frame(width: 130, height: 130)
                                    .foregroundColor(Color.white)
                                    .background(Color.red)
                            } // 「緊急かつ重要」Buttonここまで

                            Button(action: {
                                selectedPriority = .emergencyHighAndImportantLow
                                isShowTap.toggle()
                            }) {
                                // 緊急だが重要でない
                                // Urgent but unimportant
                                Text(PriorityEnum.emergencyHighAndImportantLow.displayString)
                                    .frame(width: 130, height: 130)
                                    .foregroundColor(Color.white)
                                    .background(Color.yellow)
                            } // 「緊急だが重要でない」Buttonここまで
                        } // Hstackここまで
                        HStack {
                            Button(action: {
                                selectedPriority = .emergencyLowAndImportantHigh
                                isShowTap.toggle()
                            }) {
                                // 緊急でないが重要
                                // Not urgent, but important
                                Text(PriorityEnum.emergencyLowAndImportantHigh.displayString)
                                    .frame(width: 130, height: 130)
                                    .foregroundColor(Color.white)
                                    .background(Color.green)
                            } // 「緊急でないが重要」Buttonここまで

                            Button(action: {
                                selectedPriority = .emergencyLowAndImportantLow
                                isShowTap.toggle()
                            }) {
                                //　緊急でなく重要でない
                                //  Not urgent, not important.
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
                NavigationLink(destination: RegistrationView(selectedPriority: $selectedPriority), isActive: $isShowTap) {
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
