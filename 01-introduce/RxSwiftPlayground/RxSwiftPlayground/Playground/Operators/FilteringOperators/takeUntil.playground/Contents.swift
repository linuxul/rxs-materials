
import UIKit
import RxSwift

/*:
 # take(until:)
 */

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]






let subject = PublishSubject<Int>()
let trigger = PublishSubject<Int>()

// trigger가 방출하기 전까지 요소를 방출을 하도록 한다.
subject.takeUntil(trigger)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(1)
subject.onNext(2)
subject.onNext(3)

trigger.onNext(0)

subject.onNext(10)








