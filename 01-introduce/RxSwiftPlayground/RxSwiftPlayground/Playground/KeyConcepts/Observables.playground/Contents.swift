
import UIKit
import RxSwift
import Dispatch

let disposeBag = DisposeBag()
/*:
 # Observables
 */
// Observable ->(Next, Emission)  Observer (Subscribe)
//              (Error, Complete) - Notification
// error 이벤트 후 Next로 받지 않음. 마블 Marble, RxMable
// #1
let o1 = Observable<Int>.create { (observer) -> Disposable in
    observer.on(.next(0))
    observer.onNext(1)

    observer.onCompleted()
    // 이후에 이벤트를 전달을 할 수 없음.

    return Disposables.create()
}

o1.subscribe {
    print($0)

    if let element = $0.element {
        print(element)
    }
    print("=== end ====")
}


print("===========")

o1.subscribe(onNext: { element1 in
    print(element1)
})


// #2
Observable.from([0, 1, 2, 3, 4])






