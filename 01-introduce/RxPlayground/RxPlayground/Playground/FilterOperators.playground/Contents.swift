import UIKit
import RxSwift
import RxRelay

// 1
enum MyError: Error {
    case anError
}

// 2
func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, (event.element ?? event.error) ?? event)
}

// 모든 이벤트를 무시를 한다. completed, error만 통과한다.
example(of: "ignoreElements") {

    // 1
    let strikes = PublishSubject<String>()
    let disposeBag = DisposeBag()

    // 2
    strikes
        .ignoreElements()
        .subscribe {
            print("ignore = \($0)")
        }
        .disposed(by: disposeBag)

    strikes
        .subscribe {
            print(label: "2)", event: $0)
        }
        .disposed(by: disposeBag)

    strikes.onNext("X")
    strikes.onNext("X")
    strikes.onNext("X")

    strikes.onCompleted()
}

// n번째 요소만 처리. 방출이 되고 즉시 종료가 된다.
example(of: "ignoreElements") {

    // 1
    let strikes = PublishSubject<String>()
    let disposeBag = DisposeBag()

    // 2
    strikes
        .element(at: 1)
        .subscribe {
            print(label: "1)", event: $0)
        }
        .disposed(by: disposeBag)

    strikes
        .subscribe {
            print(label: "2)", event: $0)
        }
        .disposed(by: disposeBag)

    strikes.onNext("1")
    strikes.onNext("2")
    strikes.onNext("3")

    strikes.onCompleted()
}


// 필터링 모두 또는 하나 이상인 경우 처리
example(of: "filter") {

    // 1
    let disposeBag = DisposeBag()

    // 2
    Observable.of(1, 2, 3, 4, 5, 6)
        .filter { $0.isMultiple(of: 2) }
        .subscribe {
            print(label: "1)", event: $0)
        }
        .disposed(by: disposeBag)
}


// 특정 수의 요소를 건너뛰려면 사용하는 연산자, 처음의 n개의 요소를 무시할 수 있습니다.
example(of: "filter") {

    // 1
    let disposeBag = DisposeBag()

    // 2
    Observable.of(1, 2, 3, 4, 5, 6)
        .skip(3)
        .subscribe {
            print(label: "1)", event: $0)
        }
        .disposed(by: disposeBag)

}


// 햐당 항목이 있을 때까지만 건너뛴 다음 해당 시점부터 다른 모든 항목을 통과시킵니다.
example(of: "skip(while:)") {

    // 1
    let disposeBag = DisposeBag()

    // 2
    Observable.of(2, 2, 3, 4, 4)
        .skip(while: {
            $0.isMultiple(of: 2)
        })
        .subscribe {
            print(label: "1)", event: $0)
        }
        .disposed(by: disposeBag)

}

// 첫 번째는 skipUntil 다른 트리커 observable이 방출될 때까지 소스 observable(구독 중인 항목)에서 요소를 계속 건너뛰는 것.
example(of: "skip(until:)") {

    // 1
    let disposeBag = DisposeBag()
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()

    // 2
    subject
        .skip(until: trigger)
        .subscribe {
            print(label: "1)", event: $0)
        }
        .disposed(by: disposeBag)

    subject.onNext("1")
    subject.onNext("2")

    trigger.onNext("Start")
    subject.onNext("3")


}



print("End!!")



