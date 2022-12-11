
import UIKit
import RxSwift

/*:
 # flatMapFirst
 */

let disposeBag = DisposeBag()

let redCircle = "🔴"
let greenCircle = "🟢"
let blueCircle = "🔵"

let redRectangle = "🟥"
let greenRectangle = "🟩"
let blueRectangle = "🟦"

// redCircle만 방출하는 것만 사용을 하도록 한다. - 동시에 방출
Observable.from([redCircle, greenCircle, blueCircle])
    .flatMapFirst { circle -> Observable<String> in
        switch circle {
        case redCircle:
            return Observable.repeatElement(redRectangle)
                .take(5)
        case greenCircle:
            return Observable.repeatElement(greenRectangle)
                .take(5)
        case blueCircle:
            return Observable.repeatElement(blueRectangle)
                .take(5)
        default:
            return Observable.just("")
        }
    }
    .subscribe { print($0) }
    .disposed(by: disposeBag)



//let sourceObservable = PublishSubject<String>()
//
//// 0.5초 주기로 방출
//sourceObservable
//    .flatMapFirst { circle -> Observable<String> in
//        switch circle {
//        case redCircle:
//            return Observable<Int>.interval(.milliseconds(200), scheduler: MainScheduler.instance)
//                .map { _ in redRectangle }
//                .take(10)
//        case greenCircle:
//            return Observable<Int>.interval(.milliseconds(200), scheduler: MainScheduler.instance)
//                .map { _ in greenRectangle }
//                .take(10)
//        case blueCircle:
//            return Observable<Int>.interval(.milliseconds(200), scheduler: MainScheduler.instance)
//                .map { _ in blueRectangle }
//                .take(10)
//        default:
//            return Observable.just("")
//        }
//    }
//    .subscribe { print($0) }
//    .disposed(by: disposeBag)
//
//sourceObservable.onNext(redCircle)
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//    sourceObservable.onNext(blueCircle)
//}
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
//    sourceObservable.onNext(greenCircle)
//}
//

