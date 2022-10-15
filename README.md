#  タスクアプリ（モチベーション維持）

##1.概要
タスクの重要度によって、優先順位を決めて登録するアプリです。
4つの重要度に分けており、短期的に達成したい目標や、これから挑戦したいことなどを記録します。

今後はグラフなどを用いてタスク達成度の確認ができるように改善していきます。

##2.実行画面

/Users/ken/Desktop/Simulator Screen Recording - iPhone 14 Pro - 2022-10-08 at 21.58.37.mp4

##3.アプリの機能
###ホーム画面
![Simulator Screen Shot - iPhone 14 Pro - 2022-10-09 at 16 23 15](https://user-images.githubusercontent.com/90130731/195977810-fa7c14e0-359e-4faf-bbf3-3d2324a0d136.png)

ホーム画面では4つの優先順位毎にButtonを設置し、画面下部にTabViewをセットしてホーム画面とタスクListの一覧画面を
切り替えるように設計しました。
優先順位ボタンをタップするとsheetモディファイアでタスク登録画面に遷移します。

###登録画面

![Simulator Screen Shot - iPhone 14 Pro - 2022-10-09 at 17 37 31](https://user-images.githubusercontent.com/90130731/195977831-0e3a33c6-f468-4231-a95a-cfb94d3c6562.png)

タスク登録画面では、CoreDataを活用してタスクの件名、詳細内容、タスクの実行日を登録できます。
タスクの件名、詳細内容につきましてはTextFieldを利用し、日付はDatePickerを利用しました。
またタスクの再設定を行いたい場合は、Pickerを使用してリセットできます。

優先順位に沿ってタスクをCoreDataに動的に登録できるようにコードを記述しております。

###タスク一覧画面
| ![Simulator Screen Shot - iPhone 14 Pro - 2022-10-09 at 16 16 41](https://user-images.githubusercontent.com/90130731/195977873-ea3a5f9b-3def-4187-8877-adb488c8ec9f.png) | ![Simulator Screen Shot - iPhone 14 Pro - 2022-10-09 at 16 16 43](https://user-images.githubusercontent.com/90130731/195977888-4ec60c61-023c-4812-be80-7509bbe64dfe.png) | 
CoreDataからListとForEachを利用して値を取り出し、登録したタスクを一覧表示します。
画面上部に優先順位を記したButtonをセットしており、表示させたい優先順位のボタンをタップすると、
その優先順位で登録したタスクを一覧表示させます。

##4.ダウンロードリンク
[‎タスクアプリ (モチベーション維持)](https://apps.apple.com/jp/app/%E3%82%BF%E3%82%B9%E3%82%AF%E3%82%A2%E3%83%97%E3%83%AA-%E3%83%A2%E3%83%81%E3%83%99%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E7%B6%AD%E6%8C%81/id1634411803)
##5.アプリの設計について

![1期_石岡顕さん - Frame 2](https://user-images.githubusercontent.com/90130731/195977939-ec3d2fb3-6324-4510-af7b-804bf88e8e8c.jpg)

|  ファイル名  | 解説・概要  |
| ---- | ---- |
|  ContentView.swift  |  TabViewを使用し、HomeViewとSaveViewの2画面を管理するView  |
|  HomeView.swift  |  4つの優先順位毎にタスクを登録するButtonを配置したView。 |
|  RegistrationView.swift | HomeViewでタップしたButtonの遷移先としてsheetモディファイアを使用。CoreDataを利用し、タスクの件名、内容、期日を登録し優先順位を再設定する項目を表示するView。件名、内容はTextFild、期日はDatePicker、優先順位を再設定する項目はPickerで設定する。 |
|  SavedView.swift | RegistrationViewで優先順位毎に登録したタスクを、Listで表示を担当するView |
|  TaskListView.swift |  |
|  EditView.swift | SavedViewでList表示されたタスクをタップした際に、タスクの内容と期日を編集を担当するView |
|  SavedViewModel.swift | リストを削除するメソッドを記述したクラス。 |
|  RegistrationViewModel.swift | タスクを登録するメソッドを記述したクラス |
|  EditMemoViewModel.swift | Listをタップした際にタスク内容と期日を編集するメソッドを記述したクラス |
|  PriorityModelView.swift | 優先度の名称を管理する列挙体 |
 

##6.アプリを作った時にこだわったポイント
###ポイント1.CoreDataを活用し優先順位毎に登録するタスクを動的に検索・表示出来るように工夫しました。
SavedViewで子ViewのTaskListViewを呼び出す際に、優先度毎にListを表示出来るようにしました。
タスク登録画面で優先度を決める値をCoreDataのpriorityに代入する。
TaskListViewの画面上部に優先度毎に表示できるボタンを配置し、変数priorityCategoryに値を代入する。
タップするとタスク登録画面でCoreDataに代入したpriorityとpriorityCategoryの値を比較させ、その優先度で登録したタスクをList表示できます。

```Swift
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
                            Text("タスク一覧")
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

![1期_石岡顕さん - Frame 3](https://user-images.githubusercontent.com/90130731/195979462-4db4ef17-2c4f-426a-9d3c-df5ff4c55909.jpg)
[](https://speakerdeck.com/ken20215/tasukuapuri-motibesiyonwei-chi)
##7.開発環境
* Xcode14.0.1 
* macOS Monterey 12.6
* iOS16.0

##8.作成者
