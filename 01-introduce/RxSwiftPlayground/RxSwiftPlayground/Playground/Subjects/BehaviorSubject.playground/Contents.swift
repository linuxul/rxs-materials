
import UIKit
import RxSwift

/*:
 # BehaviorSubject
 */
// subscribe가 발생하면, 발생한 시점 이전에 발생한 이벤트 중 가장 최신의 이벤트를 전달받는다.


let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}

let p1 = PublishSubject<Int>()
p1.subscribe { print("PublishSubject >> ", $0) }
.disposed(by: disposeBag)
p1.onNext(2)

let b1 = BehaviorSubject<Int>(value: 0)
b1.subscribe { print("BehaviorSubject1 >> ", $0) }
.disposed(by: disposeBag)

b1.onNext(100)

b1.subscribe { print("BehaviorSubject2 >> ", $0) }
.disposed(by: disposeBag)

b1.onNext(200)

b1.subscribe { print("BehaviorSubject2-1 >> ", $0) }
.disposed(by: disposeBag)

b1.onCompleted()

b1.subscribe { print("BehaviorSubject3 >> ", $0) }
.disposed(by: disposeBag)






