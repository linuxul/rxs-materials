import UIKit
import RxSwift

//var greeting = "Hello, playground"
//
//Observable<Int>.just(0)
//    .subscribe(onNext: { element in
//        print("onNext : \(element)")
//    })
//

example(of: "just, of, from", action: {
    // 1
    let one = 1
    let two = 2
    let three = 3

    // 2
    let observable = Observable<Int>.just(one)
    observable.subscribe { element in
        print(element)
    }


    // 3
    let observable2 = Observable.of(one, two, three)
    observable2.subscribe { element in
        print(element)
    }


    // 4
    let observable3 = Observable.of([one, two, three])
    observable3.subscribe { element in
        print(element)
    }


    // 5
    let observable4 = Observable.from([one, two, three])
    observable4.subscribe { element in
        print(element)
    }

    print("event")
    observable4.subscribe { event in
        if let element = event.element {
            print(element)
        }
    }

    print("element")
    observable4.subscribe { element in
        print(element)
    }

})


