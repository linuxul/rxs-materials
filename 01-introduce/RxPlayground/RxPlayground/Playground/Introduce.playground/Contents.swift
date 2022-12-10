import UIKit
import RxSwift

var greeting = "Hello, playground"

Observable<Int>.just(0)
    .subscribe(onNext: { element in
        print("onNext : \(element)")
    })

