
import UIKit
import RxSwift

/*:
 # combineLatest
 */

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let greetings = PublishSubject<String>()
let languages = PublishSubject<String>()

// observale은 하나의 값을 방출하면 조합을 해서 방출을 하도록 한다.
Observable.combineLatest(greetings, languages) { lhs, rhs -> String in
    return "\(lhs) \(rhs)"
}
.subscribe { print($0) }
.disposed(by: bag)

greetings.onNext("Hi")
languages.onNext("World!")

greetings.onNext("Hello")
languages.onNext("RxSwift")

//greetings.onCompleted()
// 구독자중에 하나라도 에러가 발생을 하면 onError를 받는다.
greetings.onError(MyError.error)

languages.onNext("SwiftUI")
languages.onCompleted()




