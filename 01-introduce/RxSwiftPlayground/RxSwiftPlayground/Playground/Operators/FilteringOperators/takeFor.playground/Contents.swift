
import UIKit
import RxSwift

/*:
 # take(for:scheduler:)
 */


let disposeBag = DisposeBag()

let o = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)

// 시간동안만 이벤트를 받도록 한다.
o.take(for: .seconds(3), scheduler: MainScheduler.instance)
    .subscribe { print($0) }
    .disposed(by: disposeBag)


