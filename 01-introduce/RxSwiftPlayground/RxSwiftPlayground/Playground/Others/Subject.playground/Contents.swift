import UIKit
import RxSwift
import RxRelay

example(of: "PublishSubject") {

    var disposeBag = DisposeBag()

    // 1
    let publishSubject = PublishSubject<String>()

    publishSubject.on(.next("Is anyone listening?"))

    let subscriptionOne = publishSubject
        .subscribe(onNext: { string in
            print(string)
        })
        .disposed(by: disposeBag)

    publishSubject.onNext("It's me.")

    publishSubject.onNext("2")


    let subscriptionTwo = publishSubject
        .subscribe(onNext: {
            print("Next \($0)")
        })
        .disposed(by: disposeBag)

    publishSubject.onNext("3")


    let subscriptionThree = publishSubject
        .subscribe(
            onNext: { event in
                print("event = \(event)")
            },
            onError: { error in
                print("onError \(error)")
            },
            onCompleted: {
                print("3) onCompleted")
            },
            onDisposed: {
                print("onDisposed")
            }
        )
        .disposed(by: disposeBag)


    publishSubject.onNext("Final!!")
    publishSubject.onNext("Final!!!!")

    publishSubject.onCompleted()

    publishSubject.onNext("completed after")

    disposeBag = DisposeBag()

    publishSubject
        .subscribe {
            print("3)", $0.element ?? $0)
        }
        .disposed(by: disposeBag)

    publishSubject.onNext("???")

}


// 1
enum MyError: Error {
    case anError
}

// 2
func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, (event.element ?? event.error) ?? event)
}

// 3
example(of: "BehaviorSubject") {
    // 4
    let subject = BehaviorSubject(value: "Initial value")
    let disposeBag = DisposeBag()

    subject
        .subscribe {
            print(label: "1)", event: $0)
        }
        .disposed(by: disposeBag)

    subject.onNext("X")

    subject.onError(MyError.anError)

    subject
        .subscribe {
            print(label: "2)", event: $0)
        }
        .disposed(by: disposeBag)

}


example(of: "ReplaceSubject") {

    // 1
    let subject = ReplaySubject<String>.create(bufferSize: 2)
    let disposeBag = DisposeBag()

    subject.onNext("1")
    subject.onNext("2")
    subject.onNext("3")
    subject.onNext("4")

    // 3
    subject
        .subscribe {
            print(label: "1)", event: $0)
        }
        .disposed(by: disposeBag)

    subject.onNext("5")
    print("++++++++++++++++++++++++++++")

    subject
        .subscribe {
            print(label: "2)", event: $0)
        }
        .disposed(by: disposeBag)

    subject.onNext("6")
    print("++++++++++++++++++++++++++++")

    subject
        .subscribe {
            print(label: "3)", event: $0)
        }
        .disposed(by: disposeBag)
    print("++++++++++++++++++++++++++++")

    subject.onNext("7")

    subject.onError(MyError.anError)

    subject.onNext("8")

}

// Relay는 onNext 대신 accept를 사용한다. Error 이벤트를 추가 할 수 없다. 종료를 하지 않는다.
example(of: "PublishRelay") {

    // 1
    let relay = PublishRelay<String>()
    let disposeBag = DisposeBag()

    relay.accept("Knock knock, anyone home?")

    relay
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)

    relay.accept("1")
    relay.accept("2")
    relay.accept("3")
    relay.accept("4")
//    relay.accept(MyError.anError)
//    relay.onCompleted()

}


example(of: "BehaviorRelay") {

    // 1
    let relay = BehaviorRelay(value: "Initial value")
    let disposeBag = DisposeBag()

    // 2
    relay.accept("New Initial value")

    // 3
    relay
        .subscribe {
            print(label: "1)", event: $0)
        }
        .disposed(by: disposeBag)

    relay.accept("1")
    relay.accept("2")

    relay
        .subscribe {
            print(label: "2)", event: $0)
        }
        .disposed(by: disposeBag)

    relay.accept("3")

    print("relay.value = \(relay.value)")

//    relay.value = "relay.value"



}




print("End!!")
