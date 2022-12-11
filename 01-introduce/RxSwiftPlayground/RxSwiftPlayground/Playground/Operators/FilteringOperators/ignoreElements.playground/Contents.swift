
import UIKit
import RxSwift

/*:
 # ignoreElements
 */

let disposeBag = DisposeBag()
let fruits = ["🍏", "🍎", "🍋", "🍓", "🍇"]

// 이 옵저버블은 complete, error 여부만 방출을 하도록 한다.
Observable.from(fruits)
    .ignoreElements()
    .subscribe { print($0) }
    .disposed(by: disposeBag)




