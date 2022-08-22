//
//  ContentView.swift
//  motivationUpTaskControl
//
//  Created by 石岡　顕 on 2022/06/24.
//

import SwiftUI

struct ContentView: View {
    var tabItems = ["house", "suit.heart.fill"]
    @State var selected =  "house"
    @State var centerX: CGFloat = 0
    @State var dipText: String = ""
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selected) {
                // HomeViewを呼び出す。
                HomeView()
                    .tag(tabItems[0])

                // SavedViewを呼び出す。
                SavedView()
                    .tag(tabItems[1])

            } // TabViewここまで
            HStack {
                ForEach(tabItems, id: \.self) { value in
                    GeometryReader { reader in
                        TabBarButton(selected: $selected, value: value, centerX: $centerX, rect: reader.frame(in: .global), dipText: $dipText)
                            .onAppear(perform: {
                                if value == tabItems.first {
                                    centerX = reader.frame(in: .global).midX
                                    dipText = "Home"
                                }
                            })
                    } //  GeometryReaderここまで
                    .frame(width: 70, height: 50)
                    if value != tabItems.last {Spacer(minLength: 0)}
                } // ForEachここまで
            } // Hstackここまで
            .padding(.horizontal, 25)
            .padding(.top)
            .padding(.bottom, 25)
            .background(Color.black.clipShape(AnimatedShape(centerX: centerX)))
            .shadow(color: Color("TabButtonColor").opacity(0.1), radius: 5, x: 0, y: -5)
            .padding(.top, -15)
        } // VStackここまで
        .ignoresSafeArea(edges: [.bottom])
    } // var bodyここまで
} // ContentViewここまで
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct TabBarButton: View {
    @Binding var selected: String
    var value: String
    @Binding var centerX: CGFloat
    var rect: CGRect
    @Binding var dipText: String
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                selected = value
                centerX = rect.midX
                if selected == value {
                    dipText = "Home"
                } else {
                    dipText = "save"
                }
            }
        }) {
            VStack {
                Image(systemName: value)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 26, height: 26)
                    .foregroundColor(selected == value ? Color.yellow : .white)

                Text(dipText)
                    .font(.caption)
                    .foregroundColor(selected == value ? Color.yellow : .white)
                    .opacity(selected == value ? 1 : 0)
            }
            .padding(.top)
            .frame(width: 70, height: 50)
            .offset(y: selected == value ? -15 : 0)
        }

    }
}

// Custom Shape
struct AnimatedShape: Shape {

    var centerX: CGFloat

    // animation Path
    var animatableData: CGFloat {
        get {return centerX}
        set {centerX = newValue}
    }

    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 15))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 15))

            // Curve
            path.move(to: CGPoint(x: centerX - 35, y: 15))
            path.addQuadCurve(to: CGPoint(x: centerX + 35, y: 15), control:
                                CGPoint(x: centerX, y: -30))
        }
    }
}
