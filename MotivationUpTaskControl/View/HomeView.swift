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
    var body: some View {
        NavigationView {
            // もしisShowtapがfalseであれば画面をそのままの状態にし、trueであれば画面をNavigationLink先に遷移させ、HomeView画面を閉じる。
            if isShowTap == false {
                ZStack {
                    VStack {
                        Spacer()
                        HStack {
                            Button(action: {
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
