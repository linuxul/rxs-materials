
import UIKit
import RxSwift

/*:
 # catchAndReturn
 */
// 에러가 발생을 하면 파라미터로 변경후 completed 이벤트를 전달하도록 한다.
let bag = DisposeBag()

enum MyError: Error {
    case error
}

let subject = PublishSubject<Int>()

subject
    .catchAndReturn(-1)
    .subscribe { print($0) }
    .disposed(by: bag)

subject.onError(MyError.error)

