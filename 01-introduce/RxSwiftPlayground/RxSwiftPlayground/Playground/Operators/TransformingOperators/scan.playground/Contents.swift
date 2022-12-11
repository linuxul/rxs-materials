
import UIKit
import RxSwift

/*:
 # scan
 */

let disposeBag = DisposeBag()

//accumulator function을 활용하는 scan 연산자에 대해 공부합니다.
Observable.range(start: 1, count: 10)
    .scan(0, accumulator: +)
    .subscribe { print($0) }
    .disposed(by: disposeBag)







