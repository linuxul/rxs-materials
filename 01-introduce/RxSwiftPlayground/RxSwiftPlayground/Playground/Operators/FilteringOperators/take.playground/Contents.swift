
import UIKit
import RxSwift

/*:
 # take
 */

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// 정수를 파라미터를 방출해서 해당 숫자만큼 방출을 하도록 한다.
Observable.from(numbers)
    .take(5)
    .subscribe { print($0) }
    .disposed(by: disposeBag)


