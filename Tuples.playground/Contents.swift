import UIKit

let mixDateType = (1, "こんにちは", true, 2.55)
print(mixDateType)
print(mixDateType.0) // 1
print(mixDateType.1) // こんにちは
print(mixDateType.2) // true
print(mixDateType.3) // 2.55
print(type(of: mixDateType)) // (Int, String, Bool, Double)

// タプル型は一意である必要はない。よって同じ値が入っても問題なし。
let sameDateType = ("りんご", "りんご")
print(sameDateType)
print(type(of: sameDateType))

// タプル型の制限として変数や定数に格納されたタプルは、配列のように値を追加することができない。
let mixDateTypeOnLabel = (id: 10, message: "こんちは", status: true, point: 2.55)
print(mixDateTypeOnLabel) // (id: 10, message: "こんちは", status: true, point: 2.55)
print(mixDateTypeOnLabel.id) // 10
print(mixDateTypeOnLabel.message) // こんにちは
print(mixDateTypeOnLabel.status) // true
print(mixDateTypeOnLabel.point) // 2.55
