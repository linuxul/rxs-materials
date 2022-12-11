
import UIKit
import RxSwift

/*:
 # take(while:)
 */

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]


Observable.from(numbers)
    .takeWhile { !$0.isMultiple(of: 2) }
    .subscribe { print($0) }
    .disposed(by: disposeBag)





