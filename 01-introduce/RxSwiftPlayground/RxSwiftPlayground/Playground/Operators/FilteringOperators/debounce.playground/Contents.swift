
import UIKit
import RxSwift

/*:
 # debounce
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


// 검색에 사용을 함. - 지정된 시간 이후에 방출을 하도록 한다.
// 지정된 시간을 안에 next 방출을 하면, 타이머가 초기화 하도록 한다. 마지막의 값이 전달이 된다.
buttonTap
    .debounce(.milliseconds(900), scheduler: MainScheduler.instance)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

