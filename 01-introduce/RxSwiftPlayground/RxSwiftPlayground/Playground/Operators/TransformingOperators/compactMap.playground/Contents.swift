
import UIKit
import RxSwift

/*:
 # compactMap
 */

let disposeBag = DisposeBag()

let redCircle = "🔴"
let greenCircle = "🟢"
let blueCircle = "🔵"

let redRectangle = "🟥"
let greenRectangle = "🟩"
let blueRectangle = "🟦"

let subject = PublishSubject<String?>()

// compactMap 값을 변환을 하도록 한다. 값이 nil 아니고, 값이 옵셔널이면 언래핑을 해서 전달을 하도록 한다.
subject
//    .filter { $0 != nil }
//    .map { $0! }
    .compactMap { $0 }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    Observable<Int>.interval(.milliseconds(300), scheduler: MainScheduler.instance)
        .take(10)
        .map { _ in Bool.random() ? redCircle : nil }
        .subscribe(onNext: { subject.onNext($0) })
        .disposed(by: disposeBag)
}

//DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//    Observable<Int>.interval(.milliseconds(700), scheduler: MainScheduler.instance)
//        .take(10)
//        .map { _ in Bool.random() ? greenCircle : nil }
//        .subscribe(onNext: { subject.onNext($0) })
//        .disposed(by: disposeBag)
//}
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
//    Observable<Int>.interval(.milliseconds(100), scheduler: MainScheduler.instance)
//        .take(10)
//        .map { _ in Bool.random() ? blueCircle : nil }
//        .subscribe(onNext: { subject.onNext($0) })
//        .disposed(by: disposeBag)
//}
