
import UIKit
import RxSwift

/*:
 # of
 */

let disposeBag = DisposeBag()
let apple = "🍏"
let orange = "🍊"
let kiwi = "🥝"

// 파라미터가 가변일 경우 여러개의 값을 방출하도록 한다.
Observable.of(apple, orange, kiwi)
    .subscribe { event in print(event)}
    .disposed(by: disposeBag)

Observable.of([[1, 2], [3, 4], [5, 6]])
    .subscribe { event in print(event)}
    .disposed(by: disposeBag)







