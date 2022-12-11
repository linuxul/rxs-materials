
import UIKit
import RxSwift

/*:
 # range
 */

let disposeBag = DisposeBag()

// 정수를 지정된 수 만큼 방출을 하도록 한다.
Observable.range(start: 1, count: 10)
    .subscribe { print($0) }
    .disposed(by: disposeBag)




