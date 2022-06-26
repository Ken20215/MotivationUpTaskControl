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
        NavigationView {
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        
                    }) {
                        // 緊急かつ重要
                        Text("Urgrnt and vital")
                            .frame(width: 130, height: 130)
                            .foregroundColor(Color.white)
                            .background(Color.red)
                    } // 「緊急かつ重要」Buttonここまで
                    
                    Button(action: {
                        
                    }) {
                        // 緊急だが重要でない
                        Text("Urgent but unimportant")
                            .frame(width: 130, height: 130)
                            .foregroundColor(Color.white)
                            .background(Color.yellow)
                    } // 「緊急だが重要でない」Buttonここまで
                } // Hstackここまで
                HStack{
                    Button(action: {
                        
                    }) {
                        // 緊急でないが重要
                        Text("Not urgent, but important")
                            .frame(width: 130, height: 130)
                            .foregroundColor(Color.white)
                            .background(Color.green)
                    } // 「緊急でないが重要」Buttonここまで
                    
                    Button(action: {
                        
                    }) {
                        //　緊急でなく重要でない
                        Text("Not urgent, not important.")
                            .frame(width: 130, height: 130)
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                    } // 「緊急でなく重要でない」Buttonここまで
                } // Hstackここまで
                TabView{
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
                }
            } // Vstackここまで
            .navigationBarTitle("Task")
        } //  NavigationViewここまで
    } // var bodyここまで
} // ContentViewここまで
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
