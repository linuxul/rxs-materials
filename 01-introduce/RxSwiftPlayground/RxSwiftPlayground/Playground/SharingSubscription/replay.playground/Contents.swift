
import UIKit
import RxSwift


/*:
 # replay, replayAll
 */

let bag = DisposeBag()
let subject = ReplaySubject<Int>.create(bufferSize: 5)
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).take(5).multicast(subject)

source
    .subscribe { print("🔵", $0) }
    .disposed(by: bag)

source
    .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe { print("🔴", $0) }
    .disposed(by: bag)

source.connect()

















