
import UIKit
import RxSwift

/*:
 # amb
 */


let bag = DisposeBag()

enum MyError: Error {
   case error
}

let a = PublishSubject<String>()
let b = PublishSubject<String>()
let c = PublishSubject<String>()

// 여러 옵저버블 중에서 가장 먼저 이벤트를 방출하는 옵저버블을 선택하는 amb 연산자에 대해 공부합니다.
//a.amb(b)
Observable.amb([a, b, c])
    .subscribe { print($0) }
    .disposed(by: bag)

a.onNext("A")
b.onNext("B")

b.onCompleted()
a.onCompleted()






