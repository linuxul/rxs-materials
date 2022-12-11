
import UIKit
import RxSwift

/*:
 # zip
 */

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let numbers = PublishSubject<Int>()
let strings = PublishSubject<String>()

// Indexed Sequencing을 구현하는 zip 연산자에 대해 공부합니다.
// 두 observable은 모두 같은 인텍스를 방출해야 결합해서 방출을 하도록 한다.
// 결합의 짝이 없으면 방출하지 않는다.

Observable.zip(numbers, strings) { "\($0) - \($1)" }
.subscribe { print($0) }
.disposed(by: bag)

numbers.onNext(1)
strings.onNext("one")

numbers.onNext(2)
strings.onNext("two")

// 하나의 completed 이벤트가 전달이 되면 나중의 것은 방출하지 않는다.
numbers.onCompleted()
strings.onNext("three")

// 구독자 중에 error를 하나라도 방출을 하게 되면 구독자를 에러를 방출하도록 된다.
strings.onError(MyError.error)




