
import UIKit
import RxSwift

/*:
 # merge
 */

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let oddNumbers = BehaviorSubject(value: 1)
let evenNumbers = BehaviorSubject(value: 2)
let negativeNumbers = BehaviorSubject(value: -1)

// 여러 옵저버블이 방출하는 이벤트를 하나의 옵저버블에서 방출하도록 병합하는 merge 연산자에 대해 공부합니다.

let source = Observable.of(oddNumbers, evenNumbers, negativeNumbers)

source
//    .merge()
    .merge(maxConcurrent: 2)
    .subscribe { print($0) }
    .disposed(by: bag)


oddNumbers.onNext(3)
evenNumbers.onNext(4)

evenNumbers.onNext(6)
oddNumbers.onNext(5)

negativeNumbers.onNext(-2)
// maxConcurrent가 두개이므로, observable이 onCompleted 되면 다음의 observable이 구독된다.
oddNumbers.onCompleted()

//oddNumbers.onCompleted()
// 에러를 방출을 하면 추후에 받는 이벤트를 무시를 하도록 한다. 하나라도 에러를 방출을 하면 이후는 구독자에게 전달되지 않는다.
//oddNumbers.onError(MyError.error)
//
//evenNumbers.onNext(8)
//evenNumbers.onCompleted()

// 병합된 모든 observable에서 onCompleted 이벤트를 받아야 onCompleted가 호출되도록 한다.



