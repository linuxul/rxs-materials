import UIKit
import RxSwift


// 관찰자가 기다리는 observable을 만드는 대신 각 구독작에게 새로운 Observable을 제공하는 Observable Factory를 만듦
example(of: "deferred") {

    let disposeBag = DisposeBag()

    // 1
    var flip = false

    // 2
    let factory: Observable<Int> = Observable.deferred {
        // 3
        flip.toggle()

        // 4
        if flip {
            return Observable.of(1, 2, 3)
        } else {
            return Observable.of(4, 5, 6)
        }
    }


    for _ in 0...3 {
        factory.subscribe(onNext: {
            print($0, terminator: "")
        })
        .disposed(by: disposeBag)

        print()
    }

}
























