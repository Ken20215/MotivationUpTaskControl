//
//  HomeView.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/06/26.
//

import SwiftUI

struct HomeView: View {
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
                Spacer()
            } // Vstackここまで
            .navigationBarTitle("Task")
        } //  NavigationViewここまで
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
