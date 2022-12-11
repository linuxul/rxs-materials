
import UIKit
import RxSwift

/*:
 # startWith
 */
// 옵저버블 시퀀스 앞에 새로운 요소를 추가하는 startWith 연산자에 대해 공부합니다.
// LIFO
let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5]

Observable.from(numbers)
    .startWith(0)
    .startWith(-2)
    .startWith(1, 3, 100)
    .subscribe { print($0) }
    .disposed(by: disposeBag)






