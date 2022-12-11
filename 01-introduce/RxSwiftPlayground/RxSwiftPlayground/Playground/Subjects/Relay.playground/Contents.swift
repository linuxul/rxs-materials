
import UIKit
import RxSwift
import RxCocoa

/*:
 # Relay
 */
// PublishRelay - PublishSubject - Next이벤트만 전달을 한다. 종료가 되지 않고, dispose가 될때 종료를 하도록 한다.
// BehaviorRelay - BehaviorSubject - Next이벤트만 전달을 한다. 종료가 되지 않고, dispose가 될때 종료를 하도록 한다.

let disposeBag = DisposeBag()

example(of: "Relay #1") {
    let prelay = PublishRelay<Int>()

    prelay.subscribe { print("publishRelay : \($0)") }
    .disposed(by: disposeBag)

    prelay.accept(1)
    prelay.accept(2)

    let brelay = BehaviorRelay<Int>(value: 2)
    brelay.accept(3)

    brelay.subscribe {
        print("behaviorRelay : \($0)")
    }.disposed(by: disposeBag)

    brelay.accept(4)


    print(brelay.value)


    let rreplay = ReplayRelay<Int>.create(bufferSize: 3)
    (1...10).forEach {
        rreplay.accept($0)
    }

    rreplay.subscribe {
        print("replayRelay : \($0)")
    }
    .disposed(by: disposeBag)


}

