
import UIKit
import RxSwift

let disposeBag = DisposeBag()

let a = BehaviorSubject(value: 1)
let b = BehaviorSubject(value: 2)

Observable.combineLatest(a, b) { $0 + $1 }
.subscribe(onNext: { print($0)} )
.disposed(by: disposeBag)

a.onNext(12)
b.onNext(22)
a.onNext(24)

let b1 = BehaviorSubject<Int>(value: 1)
let b2 = BehaviorSubject<Int>(value: 2)

Observable.combineLatest(b1, b2) { $0 + $1}
.subscribe { print($0) }
.disposed(by: disposeBag)

b1.onNext(111)
b2.onNext(0)

b1.onNext(1)
b2.onNext(20)

b1.onCompleted()
b2.onNext(1111)

b2.onCompleted()



