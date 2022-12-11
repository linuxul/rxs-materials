
import UIKit
import RxSwift

/*:
 # window
 */

let disposeBag = DisposeBag()

// window 연산자에 대해 공부합니다.
// 작은 단위의 옵서버블을 리턴하도록 한다.
// InnerObserable을 방출하도록 한다.
Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .window(timeSpan: .seconds(2), count: 3, scheduler: MainScheduler.instance)
    .take(5)
    .subscribe {
        print($0)

        if let obserable = $0.element {
            obserable.subscribe { print(" inner: ", $0) }
        }
    }
    .disposed(by: disposeBag)















