
import UIKit
import RxSwift

/*:
 # catch(_:)
 */
// 에러가 발생을 하면 recovery로 변경을 한다.

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let subject = PublishSubject<Int>()
let recovery = PublishSubject<Int>()

subject
    .catch { _ in recovery }
    .subscribe { print($0) }
    .disposed(by: bag)

subject.onError(MyError.error)
subject.onNext(1)
subject.onNext(11)

recovery.onNext(22)
recovery.onCompleted()


