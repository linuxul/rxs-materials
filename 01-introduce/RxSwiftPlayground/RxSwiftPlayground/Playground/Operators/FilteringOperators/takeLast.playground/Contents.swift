
import UIKit
import RxSwift

/*:
 # takeLast
 */

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let subject = PublishSubject<Int>()


//takeLast는 방출한 결과 중 끝에서부터 몇번째까지 방출할지 결정하고 방출할 수 있습니다.
subject.takeLast(5)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(1)
subject.onNext(2)
subject.onNext(3)

numbers.forEach { subject.onNext($0) }

subject.onCompleted()


enum MyError: Error {
    case error
}
//
//subject.onError(MyError.error)





