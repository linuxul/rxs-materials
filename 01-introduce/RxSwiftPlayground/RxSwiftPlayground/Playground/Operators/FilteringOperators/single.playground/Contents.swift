
import UIKit
import RxSwift

/*:
 # single
 */

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// 원본 요소에서 첫번째 요소만 방출, 두개 이상은 에러 발생

Observable.just(1)
    .single()
    .subscribe { print($0) }
    .disposed(by: disposeBag)


Observable.from(numbers)
    .single { $0 == 3 }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

let subject = PublishSubject<Int>()

subject.single()
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(100)
subject.onNext(101) // error



