
import UIKit
import RxSwift

/*:
 # buffer
 */

let disposeBag = DisposeBag()

// Controlled Buffering 구현에 사용되는 buffer 연산자에 대해 공부합니다.

Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .buffer(timeSpan: .seconds(5), count: 3, scheduler: MainScheduler.instance)
    .take(5)
    .subscribe { print($0) }
    .disposed(by: disposeBag)









