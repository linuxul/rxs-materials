
import UIKit
import RxSwift

/*:
 # Operators
 */

let disposeBag = DisposeBag()

example(of: "disposables #1") {
Observable.from([1, 2, 3, 4, 5, 6, 7, 8, 9])
    .filter { $0.isMultiple(of: 2) }
    .take(5)
    .subscribe { print($0) }
    .disposed(by: disposeBag)


}













