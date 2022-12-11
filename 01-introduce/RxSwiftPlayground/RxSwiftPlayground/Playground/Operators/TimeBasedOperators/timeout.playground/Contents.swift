
import UIKit
import RxSwift

/*:
 # timeout
 */


let bag = DisposeBag()

let subject = PublishSubject<Int>()

// 지정된 시간 이내에 요소를 방출하지 않으면 에러 이벤트를 전달하는 timeout 연산자에 대해 공부합니다.

//subject.timeout(.seconds(3), scheduler: MainScheduler.instance)
//    .subscribe { print($0) }
//    .disposed(by: bag)
//
//Observable<Int>.timer(.seconds(2), period: .seconds(5), scheduler: MainScheduler.instance)
//    .subscribe(onNext: { subject.onNext($0) })
//    .disposed(by: bag)
//

subject.timeout(.seconds(3), other: Observable.just(5), scheduler: MainScheduler.instance)
    .subscribe { print($0) }
    .disposed(by: bag)

Observable<Int>.timer(.seconds(2), period: .seconds(5), scheduler: MainScheduler.instance)
    .subscribe(onNext: { subject.onNext($0) })
    .disposed(by: bag)


