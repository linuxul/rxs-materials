import UIKit
import RxSwift
import Dispatch

enum MyError: Error {
    case unknown
}

let observable = Observable<String>.create { observer in
    observer.onNext("Hello")
    observer.onNext("Observable")

    observer.onCompleted()

    return Disposables.create()
}


let infallible = Infallible<String>.create { observer in

    observer(.next("Hello"))
    observer(.completed)

    return Disposables.create()
}

observable.subscribe {
    print($0)
}

infallible.subscribe {
    print($0)
}


