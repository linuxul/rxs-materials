import UIKit
import RxSwift

// completed 이벤트만 보냄
example(of: "empty") {

    let observable = Observable<Void>.empty()

    observable.subscribe(
        onNext: { element in
            print(element)
        },
        onCompleted: {
            print("Completed")
        }
    )
}

// never 연산자는 아무 것도 방출하지 않고 종료되지 않는 관찰 가능 항목
example(of: "never") {

    let observable = Observable<Void>.never()

    observable.subscribe(
        onNext: { element in
            print(element)
        },
        onCompleted: {
            print("onCompleted")
        },
        onDisposed: {
            print("onDisposed")
        }
    )
}


// 값 법위에서 관찬 가능 항목을 생성
example(of: "range") {

    // 1
    let observable = Observable<Int>.range(start: 1, count: 10)

    observable
        .subscribe(
            onNext: { i in
                // 2
                let n = Double(i)

                let fibonacci = Int(
                    ((pow(1.61803, n) - pow(0.61803, n)) / 2.23606).rounded()
                )

                print(fibonacci)
            },
            onCompleted: {
               print("onCompleted")
            },
            onDisposed: {
               print("onDisposed")
            }
        )

    observable
        .subscribe(
            onNext: { i in
                print("i = \(i)")
            },
            onCompleted: {
               print("onCompleted")
            },
            onDisposed: {
               print("onDisposed")
            }
        )

}

// 구독을 명시적으로 취소를 하려면 dispose()를 호출
example(of: "dispose") {
    // 1
    let observable = Observable.of("A", "B", "C")

    // 2
    let subscription = observable.subscribe(
        onNext: { event in
            print("event = \(event)")
        },
        onCompleted: {
           print("onCompleted")
        },
        onDisposed: {
           print("onDisposed")
        }
    )
    subscription.dispose()

    // 4
    let subscription2 = observable.subscribe(
        onNext: { event in
            print("event = \(event)")
        },
        onCompleted: {
           print("onCompleted")
        },
        onDisposed: {
           print("onDisposed")
        }
    )
    subscription2.dispose()

}

// 각 구독을 개별적으로 괸리하는 것을 지루할 수 있으므로 한번에 구독을 관리 할 수 있음.
example(of: "DisposeBag") {
    // 1
    let disposeBag = DisposeBag()

    // 2
    Observable.of("A", "B", "C")
        .subscribe (
            onNext: { event in
                print("event = \(event)")
            },
            onCompleted: {
               print("onCompleted")
            },
            onDisposed: {
               print("onDisposed")
            }
        )
        .disposed(by: disposeBag)
}


enum MyError: Error {
    case anError
}

// 구독자에서 발생시킬 모든 이벤트를 지정
example(of: "create") {

    let disposeBag = DisposeBag()

    Observable<String>.create { observer in
        // 1
        observer.onNext("1")

        // 2
        observer.onCompleted()

        // error
//        observer.onError(MyError.anError)

        // 3
//        observer.onNext("?")

        // 4
        return Disposables.create()
    }
    .subscribe (
        onNext: { event in
            print("event = \(event)")
        },
        onError: { error in
            print("onError \(error)")
        },
        onCompleted: {
           print("onCompleted")
        },
        onDisposed: {
           print("onDisposed")
        }
    )
    .disposed(by: disposeBag)
}
