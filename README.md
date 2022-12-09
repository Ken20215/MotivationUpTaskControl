#  タスクアプリ（モチベーション維持）

## 1.概要
タスクの重要度によって、優先順位を決めて登録するアプリです。
4つの重要度に分けており、短期的に達成したい目標や、これから挑戦したいことなどを記録します。

今後は登録したタスクの期日に通知機能を追加する予定です。

 <a href="https://speakerdeck.com/ken20215/tasukuahuri-motihesiyonwei-chi-shao-jie-suraito"><img alt="紹介スライド" src="https://user-images.githubusercontent.com/90130731/206172803-4fb90269-7589-4959-acfb-d78cf7a75465.png"></a>


## 2.実行画面

<a href="https://youtube.com/shorts/4dgr4d_3mhg"><img width="200" alt="デモ動画" src="https://user-images.githubusercontent.com/90130731/196175922-5f4633a9-4607-4afa-bd38-d0e8262a4106.png"></a>

## 3.アプリの機能
### ホーム画面
 
<img width="200" src="https://user-images.githubusercontent.com/90130731/195977810-fa7c14e0-359e-4faf-bbf3-3d2324a0d136.png">  


ホーム画面では4つの優先順位毎にButtonを設置し、画面下部にTabViewをセットしてホーム画面とタスクListの一覧画面を
切り替えるように設計しました。
優先順位ボタンをタップするとsheetモディファイアでタスク登録画面に遷移します。

### 登録画面

<img width="200" src="https://user-images.githubusercontent.com/90130731/195977831-0e3a33c6-f468-4231-a95a-cfb94d3c6562.png"> 

タスク登録画面では、CoreDataを活用してタスクの件名、詳細内容、タスクの実行日を登録できます。
タスクの件名、詳細内容につきましてはTextFieldを利用し、日付はDatePickerを利用しました。
またタスクの再設定を行いたい場合は、Pickerを使用してリセットできます。

優先順位に沿ってタスクをCoreDataに動的に登録できるようにコードを記述しております。

### タスク一覧画面

<img width="200" src="https://user-images.githubusercontent.com/90130731/203468545-b10751bf-8c2e-4d02-873d-78575083d44f.png">　<img width="200" src="https://user-images.githubusercontent.com/90130731/203468601-29ff077d-cb87-4c6b-a9f6-10db2170f322.png">

CoreDataからListとForEachを利用して値を取り出し、登録したタスクを一覧表示します。
画面上部に優先順位を記したButtonをセットしており、表示させたい優先順位のボタンをタップすると、その優先順位で登録したタスクを一覧表示させます。
登録したタスクを優先毎に色分けしグラフ表示させて可視化してます。

## 4.ダウンロードリンク
[![App_Store_Badge_JP](https://user-images.githubusercontent.com/68992872/204145956-f5cc0fa8-d4c9-4f2c-b1d4-3c3b1d2e2aba.png)](https://apps.apple.com/jp/app/%E3%82%BF%E3%82%B9%E3%82%AF%E3%82%A2%E3%83%97%E3%83%AA-%E3%83%A2%E3%83%81%E3%83%99%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E7%B6%AD%E6%8C%81/id1634411803)

## 5.アプリの設計について
![タスク管理アプリ  フロー図](https://user-images.githubusercontent.com/90130731/205471599-5fd0cd30-7f70-49f5-bf44-ab179de53ff5.jpg)

![1期_石岡顕さん (11)](https://user-images.githubusercontent.com/90130731/205471616-c2911826-607f-43d5-94ff-224bba1c2139.jpg)


|  ファイル名  | 解説・概要  |
| ---- | ---- |
|  ContentView.swift  |  TabViewを使用し、HomeViewとSaveViewの2画面を管理するView  |
|  HomeView.swift  |  4つの優先順位毎にタスクを登録するButtonを配置したView。 |
|  RegistrationView.swift | HomeViewでタップしたButtonの遷移先としてsheetモディファイアを使用。CoreDataを利用し、タスクの件名、内容、期日を登録し優先順位を再設定する項目を表示するView。件名、内容はTextFild、期日はDatePicker、優先順位を再設定する項目はPickerで設定する。 |
|  SavedView.swift | RegistrationViewで優先順位毎に登録したタスクをList表示を担当する子ViewのTaskListViewを呼び出し、優先順位毎に登録したタスクのグラフ描画を担当するView |
|  TaskListView.swift | 登録したタスクのList表示を担当するView |
|  EditView.swift | SavedViewでList表示されたタスクをタップした際に、タスクの内容と期日を編集を担当するView |
|  SavedViewModel.swift | リストを削除するメソッドを記述したクラス。 |
|  RegistrationViewModel.swift | タスクを登録するメソッドを記述したクラス |
|  EditMemoViewModel.swift | Listをタップした際にタスク内容と期日を編集するメソッドを記述したクラス |
|  PriorityModelView.swift | 優先度の名称を管理する列挙体 |
 

## 6.アプリを作った時にこだわったポイント
### ポイント1.CoreDataを活用し優先順位毎に登録するタスクを動的に検索・表示出来るように工夫しました。
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

### ポイント2.登録タスクをグラフで描画し進捗を確認できるように実装しました。
CoreDataに登録している登録タスクを優先順位毎にグラフに描画し、現在のタスクを可視化できるように実装行いました。
グラフ描画を行うためにWWDC22で新しく発表されたChartsを利用しました。優先順位毎に色分けをしてグラフ描画します。

登録タスクを識別できるように構造体「ChartEntry」をIdentifiableで宣言。

```Swift
struct ChartEntry: Identifiable {
    // 達成度と優先度毎のタスク登録数
    let id = UUID()
    var priority: String
    var count: Int
}
```

```Swift
    @ViewBuilder
    func AnimatedChart() -> some View {
        Chart {
            ForEach(arrayPriority) { item in
                BarMark(
                    x: .value("Count", item.count)
                )
                .foregroundStyle(by: .value("Category", item.priority))
            }
        }
        .chartForegroundStyleScale([
            PriorityEnum.emergencyHighAndImportantLow.rawValue: .yellow,
            PriorityEnum.emergencyLowAndImportantLow.rawValue: .blue,
            PriorityEnum.emergencyLowAndImportantHigh.rawValue: .green,
            PriorityEnum.emergencyHighAndImportantHigh.rawValue: .red
        ])
        .frame(height: 90)
        .padding(.top)
        .padding(.horizontal)
    }
```

グラフ描画する為に以下のメソッドを作成しました。

①CoreDataに登録している優先毎のタスクと列挙型で管理をしている優先順位の文字列を比較させて、
データがtrueであれば登録したタスクのカウント数を管理する優先度を表す変数へ「1」を代入しました。
カウントされた値をタプル型で返却を行い、優先毎の登録タスク振り分けを行いました。

```Swift
    // タスク優先度毎の登録数をチェック
    private func selectPriority(items: FetchedResults<Memo>) -> (priorityHighHigh: Int, priorityHighLow: Int, priorityLowHigh: Int, priorityLowLow: Int) {
        var priorityHighHigh = 0
        var priorityHighLow = 0
        var priorityLowHigh = 0
        var priorityLowLow = 0
        for item in items {
            if item.priority == PriorityEnum.emergencyHighAndImportantHigh.rawValue {
                priorityHighHigh += 1
            } else if item.priority == PriorityEnum.emergencyHighAndImportantLow.rawValue {
                priorityHighLow += 1
            } else if item.priority == PriorityEnum.emergencyLowAndImportantHigh.rawValue {
                priorityLowHigh += 1
            } else {
                priorityLowLow += 1
            }
        }
        return (priorityHighHigh, priorityHighLow, priorityLowHigh, priorityLowLow)
    } // selectPriorityここまで
```

②グラフに描画する為に@Stateで宣言した配列に「selectPriority」メソッドで返却されるタプル型の値を代入させ登録タスクを集計するメソッドです。
各優先度の登録カウントを引数に指定して「ChartEntry」型の配列で返却します。

```Swift
    private func assignmentNumber(totalTapleCount: (priorityHighHigh: Int, priorityHighLow: Int, priorityLowHigh: Int, priorityLowLow: Int)) -> [ChartEntry] {
        arrayPriority.removeAll()
        var priorityList: [ChartEntry] = []
        priorityList.append(ChartEntry(priority: PriorityEnum.emergencyHighAndImportantHigh.rawValue,
                                       count: totalTapleCount.priorityHighHigh))
        priorityList.append(ChartEntry(priority: PriorityEnum.emergencyHighAndImportantLow.rawValue,
                                       count: totalTapleCount.priorityHighLow))
        priorityList.append(ChartEntry(priority: PriorityEnum.emergencyLowAndImportantHigh.rawValue,
                                       count: totalTapleCount.priorityLowHigh))
        priorityList.append(ChartEntry(priority: PriorityEnum.emergencyLowAndImportantLow.rawValue,
                                       count: totalTapleCount.priorityLowLow))
        return priorityList
    }
} // SaveViewここまで
```
.onApperと.onChange内で下記記載のarrayPriority配列に「assignmentNumber」メソッドの戻り値の代入を行います。
これでタスク登録一覧画面を開いたタイミングとタスクを削除したタイミングでグラフを再描画することできます。
```Swift
    @State private var arrayPriority: [ChartEntry] = []
```

## 7.開発環境
* Xcode14.0.1 
* macOS Monterey 12.6
* iOS16.0

## 8.作成者
