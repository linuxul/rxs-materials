
import UIKit
import RxSwift

/*:
 # concatMap
 */

let disposeBag = DisposeBag()

let redCircle = "🔴"
let greenCircle = "🟢"
let blueCircle = "🔵"

let redRectangle = "🟥"
let greenRectangle = "🟩"
let blueRectangle = "🟦"

// 인터리빙을 허용하지 않는 concatMap 연산자에 대해 공부합니다.
// 색상이 뒤섞여서 방출을 하도록 한다.
// 처음 것을 방출 한 후에 다음 것을 생성하도록 한다.
Observable.from([redCircle, greenCircle, blueCircle])
    .concatMap { circle -> Observable<String> in
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














