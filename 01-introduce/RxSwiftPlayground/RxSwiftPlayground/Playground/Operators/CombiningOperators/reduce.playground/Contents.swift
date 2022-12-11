
import UIKit
import RxSwift

/*:
 # reduce
 */

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let o = Observable.range(start: 1, count: 5)

print("== scan")

// 중간 결과와 최종결과를 모두 방출을 하도록 한다.
o.scan(0, accumulator: +)
   .subscribe { print($0) }
   .disposed(by: bag)

print("== reduce")

// 시드 값과 옵저버블이 방출하는 요소를 대상으로 클로저를 실행하고 최종 결과를 옵저버블로 방출하는 reduce 연산자에 대해 공부합니다.
// 결과 값만 방출을 하도록 한다.
o.reduce(0, accumulator: +)
    .subscribe { print($0) }
    .disposed(by: bag)







