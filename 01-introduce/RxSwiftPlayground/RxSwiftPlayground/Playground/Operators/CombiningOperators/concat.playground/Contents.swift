
import UIKit
import RxSwift

/*:
 # concat
 */
// 두 개의 옵저버블을 연결하는 concat 연산자에 대해 공부합니다.
let bag = DisposeBag()
let fruits = Observable.from(["🍏", "🍎", "🥝", "🍑", "🍋", "🍉"])
let animals = Observable.from(["🐶", "🐱", "🐹", "🐼", "🐯", "🐵"])

Observable.concat([fruits, animals])
    .subscribe { print($0) }
    .disposed(by: bag)

fruits.concat(animals)
    .subscribe { print($0) }
    .disposed(by: bag)

animals.concat(fruits)
    .subscribe { print($0) }
    .disposed(by: bag)









