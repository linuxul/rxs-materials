import UIKit
import RxSwift
import RxRelay


// 접두사 및 연결
example(of: "startWith") {

    // 1
    let numbers = Observable.of(2, 3, 4)

    // 2
    let observable = numbers.startWith(1)
    _ = observable.subscribe()




}
