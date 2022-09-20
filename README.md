#  ** タスクアプリ (モチベーション維持) **

## 1.概要
このアプリは短期的な目標から中長期的な夢や目標などを記録として残し、
達成率を見える化し、日々に活かしていくアプリです。

## 2.実行画面

## 3.アプリの機能
### ホーム画面
ホーム画面はタスク毎に優先順位を決めるボタンを4つ配置している画面になります。
ボタン上部にこのアプリの使用目的や説明文を記載させて頂きました。
画面下部にはTabボタンを配置しており、各ボタンにはホーム画面と優先順位毎に記録したタスクを表示するList一覧画面の
表示ができるように設定させて頂きました。

### タスク登録画面
タスク登録画面はsheetモディファイアで遷移できるように設定しました。
登録画面につきまして、CoreDataを利用し、下記記載の各項目をデータ登録しました。
①タスクの件名
②タスクの詳細内容
③タスク実施日
④タスクの優先順位を再設定

①タスクの件名、②タスクの詳細内容はTextFieldを使用しました。
③実施日はDatePickerを使用しております。
④優先順位はPickerを使用し、優先順位を再度設定できるようにしております。

### 登録List一覧画面
タスク登録画面で記録した内容をListで表示させております。
画面上部には各優先順位毎に登録したListを選択できるようにボタンを配置しております。
Listには件名とタスクの詳細内容、タスク実施日を表示できるようにしました。

### 編集画面
NavigationViewのNavigationLinkで編集画面に遷移できるようにしております。
編集画面ではタスクの詳細内容を変更と実行日のみ変更します。
タスクの詳細内容はTextEditorで編集できるようにしております。

## 4.ダウンロードリンク

## 5.アプリの設計について

|  ファイル名  |  解説・概要  |
| ---- | ---- |
|  ContentView.swift  |  TabViewを使用して、HomeView・SavedViewの2画面を管理するView  |
|  HomeView.swift  |    |
|  RegistrationView.swift  |  メモを登録する画面  |
|  SavedView.swift  |  優先毎に登録したメモを一覧表示するためのView  |
|  TaskListView.swift  |  List一覧画面で表示するListの表示を担当するSavedViewの子View  |
|  EditMemoView.swift  |  登録したListをタップした際に編集画面を表示するView  |
|  SavedViewModel.swift  |  SavedViewで表示したListの行を削除するメソッドを設定したクラス  |
|  RegistrationViewModel.swift  |  タスク登録画面のRegistrationViewからタスクの件名、内容詳細、日時、再設定する優先度を登録するメソッドを設定したクラス |
|  EditMemoViewModel.swift  |  タスクの詳細内容と日時を変更することができるメソッドを設定したクラス  |
|  PriorityModelView.swift  |  優先順位の名称を管理する列挙体  |


## 6.アプリを作った時にこだわったポイント

###ポイント1. 優先毎にタスクを登録できるようにしました。
ホーム画面ボタンで登録したいタスクを優先毎に保存できるようにしました。

```
import SwiftUI

struct SavedView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @StateObject private var saveItems = SavedViewModel()
    // PriorityModelViewで定義した列挙値をrawValueを使用し、String型で表示できるように指示する。
    @State private var prioritys: [String] = [
        PriorityEnum.emergencyHighAndImportantHigh.rawValue,
        PriorityEnum.emergencyHighAndImportantLow.rawValue,
        PriorityEnum.emergencyLowAndImportantLow.rawValue,
        PriorityEnum.emergencyLowAndImportantHigh.rawValue
    ]
    @State private var priorityCategory = PriorityEnum.emergencyHighAndImportantHigh.rawValue
    @State private var index: Int = 0
    @State private var showEdit: Bool = false

    var body: some View {
        Group {
            VStack {
                if showEdit == false {
                    VStack {
                        // showがtrueであればText（Tasks）を表示させる。
                        HStack {
                            Text("リスト")
                                // 文字サイズを変更
                                .font(.system(size: 45, weight: .bold, design: .default))
                                .foregroundColor(Color.orange)
                            Spacer()
                        } //  HStackここまで
                        .padding(.horizontal)
                        ScrollView(.horizontal) {
                            HStack {
                                Button(action: {
                                    priorityCategory = PriorityEnum.emergencyHighAndImportantHigh.rawValue
                                    self.index = 0
                                }) {
                                    Text("\(PriorityEnum.emergencyHighAndImportantHigh.rawValue)")
                                        .fontWeight(self.index == 0 ? .bold : .none)
                                        .foregroundColor(Color.white)
                                        .padding()
                                        .background {
                                            Capsule()
                                                // 影を装飾
                                                .shadow(radius: 4)
                                                .opacity(self.index == 0 ? 1 : 0.2)
                                        } // backgroundここまで
                                }
                                Button(action: {
                                    priorityCategory = PriorityEnum.emergencyHighAndImportantLow.rawValue
                                    self.index = 1
                                }) {
                                    Text("\(PriorityEnum.emergencyHighAndImportantLow.rawValue)")
                                        .fontWeight(self.index == 1 ? .bold : .none)
                                        .foregroundColor(Color.white)
                                        .padding()
                                        .background {
                                            Capsule()
                                                // 影を装飾
                                                .shadow(radius: 4)
                                                .opacity(self.index == 1 ? 1 : 0.2)
                                        } // backgroundここまで
                                }
                                Button(action: {
                                    priorityCategory =  PriorityEnum.emergencyLowAndImportantLow.rawValue
                                    self.index = 2
                                }) {
                                    Text("\( PriorityEnum.emergencyLowAndImportantLow.rawValue)")
                                        .fontWeight(self.index == 2 ? .bold : .none)
                                        .foregroundColor(Color.white)
                                        .padding()
                                        .background {
                                            Capsule()
                                                // 影を装飾
                                                .shadow(radius: 4)
                                                .opacity(self.index == 2 ? 1 : 0.2)
                                        } // backgroundここまで
                                }
                                Button(action: {
                                    priorityCategory =  PriorityEnum.emergencyLowAndImportantHigh.rawValue
                                    self.index = 3
                                }) {
                                    Text("\(PriorityEnum.emergencyLowAndImportantHigh.rawValue)")
                                        .fontWeight(self.index == 3 ? .bold : .none)
                                        .foregroundColor(Color.white)
                                        .padding()
                                        .background {
                                            Capsule()
                                                // 影を装飾
                                                .shadow(radius: 4)
                                                .opacity(self.index == 3 ? 1 : 0.2)
                                        } // backgroundここまで
                                }
                                .padding()
                            } // Hstackここまで
                        } //  ScrollViewここまで
                    } // Vstackここまで
                    .edgesIgnoringSafeArea(.top)
                    .edgesIgnoringSafeArea(.horizontal)
                    .padding(.top)
                    .padding(.horizontal)
                    .background(Color.black)
                }
                Spacer()
                // 編集画面が表示される際に、上のText「Tasks」と優先度を決めるボタンの表示を無くしたい。
                TaskListView(items: FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Memo.date, ascending: true)],
                                                 predicate: NSPredicate(format: "priority == %@", priorityCategory),
                                                 animation: .default), showEdit: $showEdit)
                Spacer()
            } //  VStackここまで
        } // Groopここまで
    } // var bodyここまで
} // SaveViewここまで

struct SaveView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
    }
}

```

## 7.開発環境
* Xcode14.0
* macOS Monterey 12.6
* iOS16.0

## 8.作成者
