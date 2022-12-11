
import UIKit
import RxSwift

/*:
 # interval
 */
// 지정된 주기마다 정수를 방출하는 interval 연산자에 대해 공부합니다.

let i = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
let s1 = i.subscribe { print("1 >> \($0)") }

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    s1.dispose()
}


var s2: Disposable?
DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    s2 = i.subscribe { print("2 >> \($0)") }
}

DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
    s2?.dispose()
}
