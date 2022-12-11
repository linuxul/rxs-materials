
import UIKit
import RxSwift

/*:
 # Scheduler
 */

let bag = DisposeBag()

let backgroungScheduleer = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())


Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9)
    .filter { num -> Bool in
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> filter")
        return num.isMultiple(of: 2)
    }
    .observe(on: backgroungScheduleer)
    .map { num -> Int in
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> map")
        return num * 2
    }
    .subscribe(on: MainScheduler.instance)
    .observe(on: MainScheduler.instance)
    .subscribe {
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> subscribe")
        print($0)
    }
    .disposed(by: bag)

