
import UIKit
import RxSwift

/*:
 # AsyncSubject
 */
// // AsyncSubject는 complete 된 시점에 마지막의 값을 전달을 하도록 한다.
let bag = DisposeBag()

enum MyError: Error {
   case error
}

let as0 = AsyncSubject<Int>()

as0
    .subscribe { print(" >>", $0) }
    .disposed(by: bag)

as0.onNext(1)

as0.onNext(2)
as0.onNext(3)

as0.onCompleted()

//as0.onError(MyError.error)


