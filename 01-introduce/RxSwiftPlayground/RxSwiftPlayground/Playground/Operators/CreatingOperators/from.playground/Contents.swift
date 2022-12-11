
import UIKit
import RxSwift

/*:
 # from
 */

let disposeBag = DisposeBag()
let fruits = ["🍏", "🍎", "🍋", "🍓", "🍇"]

// 배열의 포함된 요소를 순서대로 방출을 한다.

Observable.from(fruits)
    .subscribe { element in print(element) }
    .disposed(by: disposeBag)


Observable.from([[1, 2], [3, 4], [5, 6]])
    .subscribe { event in print(event)}
    .disposed(by: disposeBag)






