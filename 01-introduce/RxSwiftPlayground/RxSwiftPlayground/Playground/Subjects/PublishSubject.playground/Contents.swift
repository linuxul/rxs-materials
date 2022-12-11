
import UIKit
import RxSwift

/*:
 # PublishSubject
 */


//subscribe한 시점 이후에 발생되는 이벤트만 전달받는다.


let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

example(of: "disposables #1") {

    let subject = PublishSubject<String>()

    // subject는 생성자를 받지 않는다.
    // subject는 observable, observer

    subject.onNext("Hello")

    let o1 = subject.subscribe { print(">> 1", $0) }
    o1.disposed(by: disposeBag)

    subject.onNext("RxSwift")

    let o2 = subject.subscribe { print(">> 2", $0) }
    o2.disposed(by: disposeBag)

    subject.onNext("Subject")
    //subject.onCompleted()
    subject.onError(MyError.error)

    let o3 = subject.subscribe { print(">> 3", $0) }
    o3.disposed(by: disposeBag)

}



