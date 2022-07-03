//
//  ContentView.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/06/24.
//

import SwiftUI
import CoreData
import UIKit

struct ContentView: View {
    init() {
        // TabViewの背景色の設定
        // イニシャライズ内に記載することによってTabViewの背景色を変更する。
        UITabBar.appearance().backgroundColor = UIColor.gray
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
    }

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("home")
                }
                .padding()
            SaveView()
                .tabItem {
                    Image(systemName: "suit.heart.fill")
                    Text("Saved")
                }
                .padding()
            InputMemoFaile()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Registration")
                }
                .padding()
        } // TabViewここまで
    } // var bodyここまで
} // ContentViewここまで
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
