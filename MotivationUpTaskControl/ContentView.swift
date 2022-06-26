//
//  ContentView.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/06/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("home")
                }
            SaveView()
                .tabItem{
                    Image(systemName: "suit.heart.fill")
                    Text("Saved")
                }
            InputMemoFaile()
                .tabItem{
                    Image(systemName: "square.and.pencil")
                    Text("Registration")
                }
        } // TabViewここまで
    } // var bodyここまで
} // ContentViewここまで
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
