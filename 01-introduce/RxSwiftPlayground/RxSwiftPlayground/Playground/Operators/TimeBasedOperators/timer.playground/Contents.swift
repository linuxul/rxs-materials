
import UIKit
import RxSwift

/*:
 # timer
 */

let bag = DisposeBag()

// 지연 시간과 반복 주기를 지정해서 정수를 방출하는 timer 연산자에 대해 공부합니다.

//Observable<Int>.timer(.seconds(1), scheduler: MainScheduler.instance)
//    .subscribe { print($0) }
//    .disposed(by: bag)

let o1 = Observable<Int>.timer(.seconds(1), period: .milliseconds(500), scheduler: MainScheduler.instance)

let s1 = o1.subscribe { print($0) }

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    s1.dispose()
}







