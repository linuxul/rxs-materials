
import UIKit
import RxSwift

/*:
 # delaySubscription
 */

let bag = DisposeBag()

func currentTimeString() -> String {
   let f = DateFormatter()
   f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
   return f.string(from: Date())
}


// Next 이벤트가 전달되는 시점과 구독이 시작되는 시점을 지연시키는 방법을 공부합니다.
Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(10)
    .debug()
    .delaySubscription(.seconds(5), scheduler: MainScheduler.instance)
    .subscribe { print(currentTimeString(), $0) }
    .disposed(by: bag)
