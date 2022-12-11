
import UIKit
import RxSwift

/*:
 # ReplaySubject
 */
// BehaviorSubject와 유사하지만, BufferSize만큼의 최신 이벤트를 전달받는다.


let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

example(of: "ReplaySubject #1") {
    let rs1 = ReplaySubject<Int>.create(bufferSize: 3)

    (1...10).forEach { rs1.onNext($0) }

    rs1.subscribe { print("Observer 1 >>", $0) }
    .disposed(by: disposeBag)

    rs1.subscribe { print("Observer 2 >>", $0) }
    .disposed(by: disposeBag)

    rs1.onNext(11)

    rs1.subscribe { print("Observer 3 >>", $0) }
    .disposed(by: disposeBag)

    //rs1.onCompleted()
    rs1.onError(MyError.error)

    rs1.subscribe { print("Observer 4 >>", $0) }
    .disposed(by: disposeBag)
}
