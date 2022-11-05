#  タスクアプリ（モチベーション維持）

## 1.概要
タスクの重要度によって、優先順位を決めて登録するアプリです。
4つの重要度に分けており、短期的に達成したい目標や、これから挑戦したいことなどを記録します。

今後はグラフなどを用いてタスク達成度の確認ができるように改善していきます。

 <a href="https://speakerdeck.com/ken20215/tasukuapuri-motibesiyonwei-chi"><img alt="紹介スライド" src="https://user-images.githubusercontent.com/90130731/196432434-fe3e8c03-7797-4bcc-9adf-1d9dfa7d2beb.png"></a>


## 2.実行画面

<a href="https://youtube.com/shorts/RsRpHOyPpZs?feature=share"><img width="200" alt="デモ動画" src="https://user-images.githubusercontent.com/90130731/196175922-5f4633a9-4607-4afa-bd38-d0e8262a4106.png"></a>

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

<img width="200" src="https://user-images.githubusercontent.com/90130731/199233083-a77dc498-1481-4d2b-afd1-26274936fcbb.png">　<img width="200" src="https://user-images.githubusercontent.com/90130731/199233307-427ca5be-dc6f-42b4-9298-f7eac54f3eb8.png">

CoreDataからListとForEachを利用して値を取り出し、登録したタスクを一覧表示します。
画面上部に優先順位を記したButtonをセットしており、表示させたい優先順位のボタンをタップすると、
その優先順位で登録したタスクを一覧表示させます。
登録したタスクを優先毎に色分けしており進捗を可視化してます。

## 4.ダウンロードリンク
[‎タスクアプリ (モチベーション維持)](https://apps.apple.com/jp/app/%E3%82%BF%E3%82%B9%E3%82%AF%E3%82%A2%E3%83%97%E3%83%AA-%E3%83%A2%E3%83%81%E3%83%99%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E7%B6%AD%E6%8C%81/id1634411803)

## 5.アプリの設計について
![タスク管理アプリ  フロー図](https://user-images.githubusercontent.com/90130731/197327324-f903021a-7bc6-490f-81ab-7cb04620834e.jpg)

![1期_石岡顕さん (11)](https://user-images.githubusercontent.com/90130731/197327332-af16204d-7ee5-44f9-9578-96c0479adc68.jpg)


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

### ポイント2.Chartsを利用し、登録タスクの進捗を確認できるようにしました。
SavedViewで登録したタスク毎に色分けしてグラフ描画させて、進捗の確認をできるようにしました。
CoreDataに登録した優先度priorityに対して条件分岐を行い、登録タスクのcountを配列に代入しております。
登録したタスクを削除を行えばグラフの描画も連動して行えるようにしてます。

```Swift
    AnimatedChart()
    Spacer()
    // 編集画面が表示される際に、上のText「Tasks」と優先度を決めるボタンの表示を無くしたい。
        TaskListView(items: FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Memo.date, ascending: true)],
                                                 predicate: NSPredicate(format: "priority == %@", priorityCategory),
                                                 animation: .default), showEdit: $showEdit,
                             showItem: $showItem)
                Spacer()
            } //  VStackここまで
            .onAppear(perform: {
                arrayPriority.append(contentsOf: selectPriority(items: items))
                newArrayPriority.append(contentsOf: totalArrayPriority(arrayPriority: arrayPriority))
            })
            .onChange(of: showItem, perform: { item in
                if item == true {
                    arrayPriority.append(contentsOf: selectPriority(items: items))
                    newArrayPriority.append(contentsOf: totalArrayPriority(arrayPriority: arrayPriority))
                    self.showItem = false
                }
            })
        } // Groopここまで
    } // var bodyここまで

    //  横棒一つにする（帯グラフにする）
    //  x軸は達成度にする。y軸を各優先度のタスクの数（Int型）。
    @ViewBuilder
    func AnimatedChart() -> some View {
        Chart {
            ForEach(newArrayPriority) { item in
                BarMark(
                    x: .value("priority", item.count),
                    y: .value("count", item.id)
                )
                .foregroundStyle(by: .value("item Color", item.color))
            }
        }
        .chartForegroundStyleScale([
            PriorityEnum.emergencyHighAndImportantLow.rawValue: .yellow,
            PriorityEnum.emergencyLowAndImportantLow.rawValue: .blue,
            PriorityEnum.emergencyLowAndImportantHigh.rawValue: .green,
            PriorityEnum.emergencyHighAndImportantHigh.rawValue: .red
        ])
        .frame(height: 120)
        .padding(.top)
        .padding(.horizontal)
    }

    // タスクの明細
    private func selectPriority(items: FetchedResults<Memo>) -> [ChartEntry] {
        arrayPriority.removeAll()
        var priorityList: [ChartEntry] = []
        for item in items {
            if item.priority == PriorityEnum.emergencyHighAndImportantHigh.rawValue {
                priorityList.append(ChartEntry(id: "タスク割合",
                                               count: 1,
                                               color: PriorityEnum.emergencyHighAndImportantHigh.rawValue))
            } else if item.priority == PriorityEnum.emergencyHighAndImportantLow.rawValue {
                priorityList.append(ChartEntry(id: "タスク割合",
                                               count: 1,
                                               color: PriorityEnum.emergencyHighAndImportantLow.rawValue))
            } else if item.priority == PriorityEnum.emergencyLowAndImportantHigh.rawValue {
                priorityList.append(ChartEntry(id: "タスク割合",
                                               count: 1,
                                               color: PriorityEnum.emergencyLowAndImportantHigh.rawValue))
            } else {
                priorityList.append(ChartEntry(id: "タスク割合",
                                               count: 1,
                                               color: PriorityEnum.emergencyLowAndImportantLow.rawValue))
            }
        }
        return priorityList
    } // selectPriorityここまで

    private func totalArrayPriority(arrayPriority: [ChartEntry]) -> [ChartEntry] {
        newArrayPriority.removeAll()
        var newPriorityList: [ChartEntry] = []
        var jugEmergencyHighAndImportantLow: Bool = false
        var jugEmergencyLowAndImportantHigh: Bool = false
        var jugEmergencyLowAndImportantLow: Bool = false

        for item in arrayPriority {
            if item.color == PriorityEnum.emergencyHighAndImportantHigh.rawValue {
                newPriorityList.append(ChartEntry(id: "タスク割合",
                                                  count: 1,
                                                  color: PriorityEnum.emergencyHighAndImportantHigh.rawValue))
            } else {
                jugEmergencyHighAndImportantLow = true
            }
        }
        if jugEmergencyHighAndImportantLow == true {
            for item in arrayPriority {
                if item.color == PriorityEnum.emergencyHighAndImportantLow.rawValue {
                    newPriorityList.append(ChartEntry(id: "タスク割合",
                                                      count: 1,
                                                      color: PriorityEnum.emergencyHighAndImportantLow.rawValue))
                } else {
                    jugEmergencyLowAndImportantHigh = true
                }
            }
        }
        if jugEmergencyLowAndImportantHigh == true {
            for item in arrayPriority {
                if item.color == PriorityEnum.emergencyLowAndImportantHigh.rawValue {
                    newPriorityList.append(ChartEntry(id: "タスク割合",
                                                      count: 1,
                                                      color: PriorityEnum.emergencyLowAndImportantHigh.rawValue))
                } else {
                    jugEmergencyLowAndImportantLow = true
                }
            }
        }
        if jugEmergencyLowAndImportantLow == true {
            for item in arrayPriority {
                if item.color == PriorityEnum.emergencyLowAndImportantLow.rawValue {
                    newPriorityList.append(ChartEntry(id: "タスク割合",
                                                      count: 1,
                                                      color: PriorityEnum.emergencyLowAndImportantLow.rawValue))
                }
            }
        }
        return newPriorityList
    }
} // SaveViewここまで

struct SaveView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
    }
}

```

## 7.開発環境
* Xcode14.0.1 
* macOS Monterey 12.6
* iOS16.0

## 8.作成者
