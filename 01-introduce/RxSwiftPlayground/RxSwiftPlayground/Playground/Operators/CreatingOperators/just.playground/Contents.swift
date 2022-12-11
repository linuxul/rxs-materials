
import UIKit
import RxSwift

/*:
 # just
 */

let disposeBag = DisposeBag()
let element = "😀"

// 파라미터를 그대로 방출을 하도록 한다.
Observable.just(element)
    .subscribe { event in print(event)}
    .disposed(by: disposeBag)

Observable.just([1, 2, 3, 4])
    .subscribe { event in print(event)}
    .disposed(by: disposeBag)


