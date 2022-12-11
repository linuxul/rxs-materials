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
example(of: "element(at:)") {

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
example(of: "skip") {

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


// skip의 반대, 지정한 요소중 첫번째를 가져옵니다.
example(of: "take") {

    // 1
    let disposeBag = DisposeBag()

    // 2
    Observable.of(1, 2, 3, 4, 5, 6)
        .take(3)
        .subscribe {
            print(label: "1)", event: $0)
        }
        .disposed(by: disposeBag)

}


example(of: "take(while:)") {

    // 1
    let disposeBag = DisposeBag()

    // 2
    Observable.of(2, 2, 1, 4, 4, 6, 6)
        .take(while: {
            $0.isMultiple(of: 2)
        })
    //        .takeWhile { index, integer in
    //            integer.isMultiple(of: 2) && index < 3
    //        }
    //        .map(.element)
        .subscribe {
            print(label: "1)", event: $0)
        }
        .disposed(by: disposeBag)

}


example(of: "take(until:)") {

    // 1
    let disposeBag = DisposeBag()

    // 2
    Observable.of(1, 2, 3, 4, 5)
    //        .take(until: .inclusive) {
    //            $0.isMultiple(of: 2)
    //        }
        .take(until: {
            $0.isMultiple(of: 4)
        }, behavior: .exclusive)
        .subscribe {
            print(label: "1)", event: $0)
        }
        .disposed(by: disposeBag)

}


example(of: "take(until:) trigger") {

    // 1
    let disposeBag = DisposeBag()
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()

    // 2
    subject
        .take(until: trigger)
        .subscribe {
            print(label: "1)", event: $0)
        }
        .disposed(by: disposeBag)

    subject.onNext("1")
    subject.onNext("2")

    trigger.onNext("Start")
    subject.onNext("3")

}


// 중복된 연속 항목이 통과하는 것을 방지할 수 있는 연산자
example(of: "distinctUntilChanged") {
    // 1
    let disposeBag = DisposeBag()

    // 2
    Observable.of(1, 1, 2, 2, 1)
        .distinctUntilChanged()
        .subscribe {
            print(label: "1)", event: $0)
        }
        .disposed(by: disposeBag)

}


example(of: "distinctUntilChanged(:)") {
    // 1
    let disposeBag = DisposeBag()

    // 2
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut

    Observable<NSNumber>.of(10, 110, 20, 200, 210, 310)
        .distinctUntilChanged { a, b in
            guard
                let aWords = formatter.string(from: a)?.components(separatedBy: " "),
                let bWords = formatter.string(from: b)?.components(separatedBy: " ") else {
                return false
            }

            print("aWord = \(aWords)")
            print("bWord = \(bWords)")

            var containsMatch = false
            // 5
            for aWord in aWords where bWords.contains(aWord) {
                containsMatch = true
                break
            }

            return containsMatch
        }
        .subscribe {
            print(label: "1)", event: $0)
        }
        .disposed(by: disposeBag)

}

example(of: "Challenge") {
    // 도전 과제
    let contacts = [
        "603-555-1212": "Florent",
        "212-555-1212": "Shai",
        "408-555-1212": "Marin",
        "617-555-1212": "Scott"
    ]

    func phoneNumber(from inputs: [Int]) -> String {
        var phone = inputs.map(String.init).joined()

        phone.insert("-", at: phone.index(phone.startIndex, offsetBy: 3))
        phone.insert("-", at: phone.index(phone.startIndex, offsetBy: 7))

        return phone
    }

    let input = PublishSubject<Int>()

    input.onNext(0)
    input.onNext(603)

    input.onNext(2)
    input.onNext(1)

    input.onNext(7)

    "5551212".forEach {
        if let number = (Int("\($0)")) {
            input.onNext(number)
        }
    }

    input.onNext(9)

}

// Combinestagram
example(of: "Combinestagram") {

    var start = 0
    func getStartNumber() -> Int {
        start += 1
        return start
    }

    let numbers = Observable<Int>.create { observer in
        let start = getStartNumber()
        observer.onNext(start)
        observer.onNext(start+1)
        observer.onNext(start+2)
        observer.onCompleted()

        return Disposables.create()
    }

    numbers
        .subscribe(
            onNext: { element in
                print("element [\(element)]")
            },
            onCompleted: {
                print("----------------")
            }
        )

    numbers
        .subscribe(
            onNext: { element in
                print("element [\(element)]")
            },
            onCompleted: {
                print("----------------")
            }
        )


}









print("End!!")



