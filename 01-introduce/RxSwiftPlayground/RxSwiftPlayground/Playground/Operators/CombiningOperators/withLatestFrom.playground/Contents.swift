
import UIKit
import RxSwift

/*:
 # withLatestFrom
 */

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let trigger = PublishSubject<Void>()
let data = PublishSubject<String>()


// 트리거 옵저버블이 Next 이벤트를 방출하면 데이터 옵저버블이 가장 최근에 방출한 Next 이벤트를 구독자에게 전달하는 withLatestFrom 연산자에 대해 공부합니다.

trigger.withLatestFrom(data)
    .subscribe { print($0) }
    .disposed(by: bag)

data.onNext("Hello")
trigger.onNext(())
trigger.onNext(())

// data가 onCompleted를 발생을 해도 구독자는 무시를 한다.
//data.onCompleted()
//data.onError(MyError.error)
//trigger.onNext(())

// trigger가 onCompleted가 발생을 하면 구독자에서 onCompleted 발생을 한다.
trigger.onCompleted()





