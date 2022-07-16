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

    // 各優先度の押したボタンに従ってタスクメモを登録する。
    // 列挙型で管理するには押したボタンに沿ってメモを登録する。列挙体に中に優先度を定義して、その中にString型とDate型の値を入れる関数を作成。
    // ボタンタップで優先度を選ぶようにする。

    enum PriorityEnum: String {
        case emergencyHighAndImportantHigh = "緊急かつ重要"   // 緊急かつ重要
        case emergencyHighAndImportantLow =  "緊急かつ重要ではない"   // 緊急かつ重要ではない
        case emergencyLowAndImportantHigh = "緊急ではないが、重要"    // 緊急ではないが、重要
        case emergencyLowAndImportantLow  = "緊急ではないが、重要ではない"  // 緊急ではないが、重要ではない
    }

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
                                let tapButton = Memo(context: viewContext)
                                tapButton.priority = priority.rawValue
                                try? viewContext.save()
                                isShowTap.toggle()
                            }) {
                                // 緊急かつ重要
                                // urgent and vital
                                Text("緊急かつ\n重要")
                                    .frame(width: 130, height: 130)
                                    .foregroundColor(Color.white)
                                    .background(Color.red)
                            } // 「緊急かつ重要」Buttonここまで

                            Button(action: {
                                let tapButton = Memo(context: viewContext)
                                tapButton.priority = PriorityEnum.emergencyHighAndImportantLow.rawValue
                                try? viewContext.save()
                                isShowTap.toggle()
                            }) {
                                // 緊急だが重要でない
                                // Urgent but unimportant
                                Text("緊急だが\n重要でない")
                                    .frame(width: 130, height: 130)
                                    .foregroundColor(Color.white)
                                    .background(Color.yellow)
                            } // 「緊急だが重要でない」Buttonここまで
                        } // Hstackここまで
                        HStack {
                            Button(action: {
                                let tapButton = Memo(context: viewContext)
                                tapButton.priority = PriorityEnum.emergencyLowAndImportantHigh.rawValue
                                try? viewContext.save()
                                isShowTap.toggle()
                            }) {
                                // 緊急でないが重要
                                // Not urgent, but important
                                Text("緊急でないが\n重要")
                                    .frame(width: 130, height: 130)
                                    .foregroundColor(Color.white)
                                    .background(Color.green)
                            } // 「緊急でないが重要」Buttonここまで

                            Button(action: {
                                let tapButton = Memo(context: viewContext)
                                tapButton.priority = PriorityEnum.emergencyLowAndImportantLow.rawValue
                                try? viewContext.save()
                                isShowTap.toggle()
                            }) {
                                //　緊急でなく重要でない
                                //  Not urgent, not important.
                                Text("緊急でなく\n重要でない")
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
                NavigationLink(destination: Registration(), isActive: $isShowTap) {
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
