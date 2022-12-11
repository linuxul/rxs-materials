
import UIKit
import RxSwift

/*:
 # throttle
 */

let disposeBag = DisposeBag()

let buttonTap = Observable<String>.create { observer in
   DispatchQueue.global().async {
      for i in 1...10 {
         observer.onNext("Tap \(i)")
         Thread.sleep(forTimeInterval: 0.3)
      }
      
      Thread.sleep(forTimeInterval: 1)
      
      for i in 11...20 {
         observer.onNext("Tap \(i)")
         Thread.sleep(forTimeInterval: 0.5)
      }
      
      observer.onCompleted()
   }
   
   return Disposables.create {
      
   }
}

//buttonTap
//    .throttle(.microseconds(1000), scheduler: MainScheduler.instance)
//    .subscribe { print($0) }
//    .disposed(by: disposeBag)

buttonTap
    .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

//: [Next](@next)
