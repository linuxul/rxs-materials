
import UIKit
import RxSwift

/*:
 # retry
 */
// 에러가 발생을 하면 observable을 새로운 obserable로 변경하도록 하나.
// 파라미터가 없을 경우 영원히 재시도를 하도록 한다. 재시도는 +1을 더해야 한다.
let bag = DisposeBag()

enum MyError: Error {
    case error
}

var attempts = 1

let source = Observable<Int>.create { observer in
    let currentAttempts = attempts
    print("#\(currentAttempts) START")
    
    if attempts < 3 {
        observer.onError(MyError.error)
        attempts += 1
    }
    
    observer.onNext(1)
    observer.onNext(2)
    observer.onCompleted()
    
    return Disposables.create {
        print("#\(currentAttempts) END")
    }
}

source
    .retry(7)
    .subscribe { print($0) }
    .disposed(by: bag)





