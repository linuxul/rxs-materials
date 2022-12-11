
import UIKit
import RxSwift

/*:
 # error
 */

let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}

// error 이벤트를 방출을 할 경우 처리

Observable<Void>.error(MyError.error)
    .subscribe { print($0) }
    .disposed(by: disposeBag)












