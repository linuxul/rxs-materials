
import UIKit
import RxSwift

/*:
 # Disposables
 */
var disposeBag = DisposeBag()

let s0 = Observable.from([1, 2, 3])
    .subscribe(onNext: { elem in
        print("Next", elem)
    }, onError: { error in
        print("Error", error)
    }, onCompleted: {
        print("Completed")
    }, onDisposed: {
        print("Disposed")
    })

//s0.dispose()
s0.disposed(by: disposeBag)

Observable.from([1, 2, 3, 4, 5, 6])
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

//disposeBag = DisposeBag()


var s2 = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .subscribe(onNext: { elem in
        print("Next", elem)
    }, onError: { error in
        print("Error", error)
    }, onCompleted: {
        print("Completed")
    }, onDisposed: {
        print("Disposed")
    })

DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//    s2.disposed(by: disposeBag)
    s2.dispose()
})
