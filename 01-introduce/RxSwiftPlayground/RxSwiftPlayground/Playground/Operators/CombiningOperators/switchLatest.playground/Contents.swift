
import UIKit
import RxSwift

/*:
 # switchLatest
 */

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let a = PublishSubject<String>()
let b = PublishSubject<String>()

let source = PublishSubject<Observable<String>>()

source
    .switchLatest()
    .subscribe { print($0) }
    .disposed(by: bag)


a.onNext("1")
b.onNext("b")


source.onNext(a)

a.onNext("2")
b.onNext("b")

// a구독을 취소하고 b가 구독이 되도록 한다.
source.onNext(b)

a.onNext("3")
b.onNext("c")

//a.onCompleted()
//b.onCompleted()
//
//source.onCompleted()

// 최신의 구독자가 error이벤트를 방출을 하면 즉시 error 이벤트를 방출하도록 한다.
a.onError(MyError.error)
b.onError(MyError.error)



