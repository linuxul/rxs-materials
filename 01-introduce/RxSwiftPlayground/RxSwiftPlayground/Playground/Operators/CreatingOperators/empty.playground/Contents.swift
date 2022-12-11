
import UIKit
import RxSwift

/*:
 # empty
 */

let disposeBag = DisposeBag()

// 어떠한 요소도 방출을 하지 않는다.

Observable<Void>.empty()
    .subscribe { print($0) }
    .disposed(by: disposeBag)

