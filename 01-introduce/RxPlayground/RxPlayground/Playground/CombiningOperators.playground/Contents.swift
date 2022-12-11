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


// 접두사 및 연결
example(of: "startWith") {

    // 1
    let numbers = Observable.of(2, 3, 4)

    // 2
    let observable = numbers.startWith(1)
    _ = observable.subscribe(
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
}


example(of: "Observable concat") {
    // 1
    let first = Observable.of(1, 2, 3)
    let second = Observable.of(4, 5, 6)

    // 2
    let observable = Observable.concat([first, second])
    observable.subscribe(
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
        })
}


example(of: "concat") {
    // 1
    let first = Observable.of(1, 2, 3)
    let second = Observable.of(4, 5, 6)

    // 2
    let observable = first.concat(second)
    observable.subscribe(
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
        })

}


example(of: "concatMa") {
    // 1
    let sequences = [
        "German cities": Observable.of("Berlin", "Munich", "Frankfurt"),
        "Spanish cities": Observable.of("Madrid", "Barcelona", "Valencia")
    ]

    // 2
    let observable = Observable.of("German cities", "Spanish cities")
        .concatMap { country in
            sequences[country] ?? .empty()
        }

    observable.subscribe(
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
        })

}

//
example(of: "merge") {
    // 1
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()

    // 2
    let source = Observable.of(left.asObservable(), right.asObservable())

    // 3
    let observable = source.merge()
    observable.subscribe(
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
        })

    // 4
    var leftValues = ["Berlin", "Munich", "Frankfurt"]
    var rightValue = ["Madrid", "Barcelona", "Valencia"]

    repeat {
        switch Bool.random() {
        case true where !leftValues.isEmpty:
            left.onNext("Left: " + leftValues.removeFirst())
        case false where !rightValue.isEmpty:
            right.onNext("Right: " + rightValue.removeFirst())
        default:
            break
        }
    } while !leftValues.isEmpty || !rightValue.isEmpty

    // 5
    left.onCompleted()
    right.onCompleted()

}


//
example(of: "combineLatest") {
    // 1
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()

    // 3
    let observable = Observable.combineLatest(left, right) { lastLeft, lastRight in
        "L: \(lastLeft), R: \(lastRight)"
    }
    observable.subscribe(
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
        })

    // 4
    print("> Sending a value to Left")
    left.onNext("Hello,")
    print("> Sending a value to Right")
    right.onNext("world")
    print("> Sending another value to Right")
    right.onNext("RxSwift")
    print("> Sending another value to Left")
    left.onNext("Have a good day,")

    // 5
    left.onCompleted()
    right.onCompleted()

}


example(of: "combine user choice and value") {
    // 1
    let choice: Observable<DateFormatter.Style> = Observable.of(.short, .long)
    let dates = Observable.of(Date())

    let observable = Observable.combineLatest(choice, dates) { format, when -> String in
        let formatter = DateFormatter()
        formatter.dateStyle = format

        return formatter.string(from: when)
    }

    observable.subscribe(
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
        })

}


example(of: "zip") {
    // 1
    enum Weather {
        case cloudy
        case sunny
    }
    let left: Observable<Weather> = Observable.of(.sunny, .cloudy, .cloudy, .sunny)
    let right = Observable.of("Lisbon", "Copenhagen", "London", "Madrid", "Vienna")

    let observable = Observable.zip(left, right) { weather, city in
        return "It's \(weather) in \(city)."
    }

    observable.subscribe(
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
        })

}


example(of: "withLatestFrom") {
    // 1
    let button = PublishSubject<Void>()
    let textField = PublishSubject<String>()

    // 2
    let observable = button.withLatestFrom(textField)
    observable.subscribe(
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
        })

    textField.onNext("Par")
    textField.onNext("Pari")
    textField.onNext("Paris")

    button.onNext(())
    button.onNext(())

    textField.onNext("Paris!")

    button.onNext(())

}


example(of: "amb") {
    // 1
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()

    // 3
    let observable = left.amb(right)
    observable.subscribe(
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
        })

    // 4
    left.onNext("Lisbon")
    right.onNext("Copenhagen")
    left.onNext("London")
    left.onNext("Madrid")
    right.onNext("Vienna")

    // 5
    left.onCompleted()
    right.onCompleted()

}


example(of: "switchLatest") {
    // 1
    let one = PublishSubject<String>()
    let two = PublishSubject<String>()
    let three = PublishSubject<String>()

    let source = PublishSubject<Observable<String>>()

    // 2
    let observable = source.switchLatest()
    let disposable = observable.subscribe(
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
        })

    source.onNext(one)
    one.onNext("Some text from sequence one")
    two.onNext("Some text from sequence two")

    source.onNext(two)
    two.onNext("More text from sequence two")
    one.onNext("and also from sequence one")

    source.onNext(three)
    two.onNext("Why don't you see me?")
    one.onNext("I'm alone, help me")
    three.onNext("Hey it's three. I win.")

    source.onNext(one)
    one.onNext("Nope, It's me. one!")

    disposable.dispose()
}


example(of: "reduce") {
    let source = Observable.of(1, 3, 5, 7, 9)

    // 1
    let observable = source.reduce(0, accumulator: +)
    _ = observable.subscribe(
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
        })
}



example(of: "scan") {
    let source = Observable.of(1, 3, 5, 7, 9)

    // 1
    let observable = source.scan(0, accumulator: +)
    _ = observable.subscribe(
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
        })
}




























