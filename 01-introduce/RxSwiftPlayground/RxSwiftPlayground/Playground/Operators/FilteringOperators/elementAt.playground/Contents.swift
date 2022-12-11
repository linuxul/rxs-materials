
import UIKit
import RxSwift

/*:
 # elementAt
 */

let disposeBag = DisposeBag()
let fruits = ["🍏", "🍎", "🍋", "🍓", "🍇"]

// 특정 인덱스에 있는 원소 하나만 방출하도록 한다.

Observable.from(fruits)
    .element(at: 2)
    .subscribe { print($0) }
    .disposed(by: disposeBag)


