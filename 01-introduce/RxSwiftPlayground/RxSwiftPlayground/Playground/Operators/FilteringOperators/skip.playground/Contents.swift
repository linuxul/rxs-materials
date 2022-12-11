
import UIKit
import RxSwift

/*:
 # skip
 */

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// observable에서 방출하는 숫자중에서 지정된 값만큼 무시를 한 후에 데이터를 전달 한다.
Observable.from(numbers)
    .skip(3)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

