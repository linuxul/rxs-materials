
import UIKit
import RxSwift

/*:
 # toArray
 */

let disposeBag = DisposeBag()

let subject = PublishSubject<Int>()
// source obserable이 종료되는 시점에 배열로 만들도록 한다.

subject
    .toArray()
    .subscribe { print($0) }
    .disposed(by: disposeBag)


subject.onNext(1)
subject.onNext(2)
subject.onNext(3)
subject.onNext(4)

subject.onCompleted()


