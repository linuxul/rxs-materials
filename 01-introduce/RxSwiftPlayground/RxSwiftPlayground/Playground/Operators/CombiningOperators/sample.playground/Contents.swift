
import UIKit
import RxSwift

/*:
 # sample
 */

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let trigger = PublishSubject<Void>()
let data = PublishSubject<String>()

// 트리거 옵저버블이 Next 이벤트를 전달할 때마다 데이터 옵저버블이 Next 이벤트를 방출하지만, 동일한 Next 이벤트를 반복해서 방출하지 않는 sample 연산자에 대해 공부합니다.

data.sample(trigger)
    .subscribe { print($0) }
    .disposed(by: bag)


trigger.onNext(())
data.onNext("Hello")


trigger.onNext(())
trigger.onNext(())
data.onNext("Hi")
trigger.onNext(())

//data.onCompleted()
//trigger.onNext(())

data.onError(MyError.error)


