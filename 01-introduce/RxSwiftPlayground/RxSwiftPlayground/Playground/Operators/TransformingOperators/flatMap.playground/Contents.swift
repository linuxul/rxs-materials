
import UIKit
import RxSwift

/*:
 # flatMap
 */

let disposeBag = DisposeBag()

let redCircle = "🔴"
let greenCircle = "🟢"
let blueCircle = "🔵"

let redRectangle = "🟥"
let greenRectangle = "🟩"
let blueRectangle = "🟦"


// InnerObserable을 사용하도록 한다.
// 평탄화
// Interleaving - 순서대로 처리되지 않는다.
Observable.from([redCircle, greenCircle, blueCircle])
    .flatMap{ circle -> Observable<String> in
        switch circle {
        case redCircle:
            return Observable.repeatElement(redRectangle).take(5)
        case greenCircle:
            return Observable.repeatElement(greenRectangle).take(5)
        case blueCircle:
            return Observable.repeatElement(blueRectangle).take(5)
        default:
            return Observable.just("")
        }
    }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

