
import UIKit
import RxSwift
import Dispatch

/*:
 # create
 */

let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}

Observable<String>.create { (observer) -> Disposable in
    guard let url = URL(string: "https://www.apple.com") else {
        observer.onError(MyError.error)

        return Disposables.create()
    }

    guard let html = try? String(contentsOf: url, encoding: .utf8) else {
        observer.onError(MyError.error)
        return Disposables.create()
    }

    observer.onNext(html)
    observer.onCompleted()

    observer.onNext("After Completed")

    return Disposables.create()
}.subscribe { print($0) }
.disposed(by: disposeBag)





