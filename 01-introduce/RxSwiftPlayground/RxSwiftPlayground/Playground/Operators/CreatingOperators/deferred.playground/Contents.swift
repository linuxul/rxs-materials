
import UIKit
import RxSwift

/*:
 # deferred
 */

let disposeBag = DisposeBag()
let animals = ["🐶", "🐱", "🐹", "🐰", "🦊", "🐻", "🐯"]
let fruits = ["🍎", "🍐", "🍋", "🍇", "🍈", "🍓", "🍑"]
var flag = true

// 특정조건에 따라서 Obserable을 생성할 수 있음.

let factory = Observable<String>.deferred {
    flag.toggle()

    if flag {
        return Observable.from(animals)
    } else {
        return Observable.from(fruits)
    }
}

factory.subscribe { print($0) }
.disposed(by: disposeBag)

factory.subscribe { print($0) }
.disposed(by: disposeBag)


factory.subscribe { print($0) }
.disposed(by: disposeBag)






