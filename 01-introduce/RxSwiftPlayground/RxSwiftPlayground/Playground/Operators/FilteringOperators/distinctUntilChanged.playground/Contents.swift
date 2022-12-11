
import UIKit
import RxSwift

/*:
 # distinctUntilChanged
 */

struct Person {
    let name: String
    let age: Int
}

let disposeBag = DisposeBag()
let numbers = [1, 1, 3, 2, 2, 3, 1, 5, 5, 7, 7, 7]
let tuples = [(1, "하나"), (1, "일"), (1, "one")]
let persons = [
    Person(name: "Sam", age: 12),
    Person(name: "Paul", age: 12),
    Person(name: "Tim", age: 56)
]




let o1 = Observable.from(numbers)
    .distinctUntilChanged()
    .subscribe { print($0) }
    .disposed(by: disposeBag)


let ps = PublishSubject<Int>()

ps.distinctUntilChanged()
    .subscribe { print($0) }
    .disposed(by: disposeBag)

ps.onNext(10)
ps.onNext(10)
ps.onNext(11)
ps.onNext(11)





