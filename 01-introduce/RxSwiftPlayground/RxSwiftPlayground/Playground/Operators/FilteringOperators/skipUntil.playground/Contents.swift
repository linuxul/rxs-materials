
import UIKit
import RxSwift

/*:
 # skip(until:)
 */

let disposeBag = DisposeBag()


//이 시퀀스에 skipUntil을 걸고, 다른 시퀀스를 전달해주면 어떻게 될까? (다른 시퀀스는 trigger 시퀀스라고 하자.)
//결과는, Trigger시퀀스의 이벤트가 발생할 때 까지, 원래 시퀀스의 모든 이벤트가 skip된다.

let subject = PublishSubject<Int>()
let trigger = PublishSubject<Int>()

subject.skip(until: trigger)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(1)
trigger.onNext(0)

subject.onNext(11)

