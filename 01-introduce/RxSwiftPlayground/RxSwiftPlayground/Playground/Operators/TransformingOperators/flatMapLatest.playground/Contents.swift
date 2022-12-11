//
//  Mastering RxSwift
//  Copyright (c) KxCoding <help@kxcoding.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import RxSwift

/*:
 # flatMapLatest
 */

let disposeBag = DisposeBag()

let redCircle = "🔴"
let greenCircle = "🟢"
let blueCircle = "🔵"

let redRectangle = "🟥"
let greenRectangle = "🟩"
let blueRectangle = "🟦"

let sourceObservable = PublishSubject<String>()
let trigger = PublishSubject<Void>()

//가장 최근 이너 옵저버블에서만 이벤트를 방출하는 flatMapLatest 연산자에 대해 공부합니다.
// 새로운 innerObserable을 생성하면은 기존 innerObserable은 제거 된다.
sourceObservable
//    .flatMap { circle -> Observable<String> in
    .flatMapLatest { circle -> Observable<String> in
        switch circle {
        case redCircle:
            return Observable<Int>.interval(.milliseconds(200), scheduler: MainScheduler.instance)
                .map { _ in redRectangle }
                .take(until: trigger)
        case greenCircle:
            return Observable<Int>.interval(.milliseconds(200), scheduler: MainScheduler.instance)
                .map { _ in greenRectangle }
                .take(until: trigger)
        case blueCircle:
            return Observable<Int>.interval(.milliseconds(200), scheduler: MainScheduler.instance)
                .map { _ in blueRectangle }
                .take(until: trigger)
        default:
            return Observable.just("")
        }
    }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

sourceObservable.onNext(redCircle)

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    // redCircle innerObserable은 사라지고 새로운 것을 생성된다. 기존 innerObserable은 사라진다.
    sourceObservable.onNext(blueCircle)
}

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    // blueCircle innerObserable은 사라지고 새로운 것을 생성된다. 기존 innerObserable은 사라진다.
    sourceObservable.onNext(greenCircle)
}

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    // greenCircle innerObserable은 사라지고 새로운 것을 생성된다. 기존 innerObserable은 사라진다.
    sourceObservable.onNext(redCircle)
}

DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
    trigger.onNext(())
}


//
//let redSubject = PublishSubject<String>()
//let greenSubject = PublishSubject<String>()
//let blueSubject = PublishSubject<String>()
//
//Observable.from([redCircle, greenCircle, blueCircle])
//    .flatMap { circle -> Observable<String> in
//        switch circle {
//        case redCircle:
//            return redSubject.asObservable()
//        case greenCircle:
//            return greenSubject.asObservable()
//        case blueCircle:
//            return blueSubject.asObservable()
//        default:
//            return Observable.just("")
//        }
//    }
//    .subscribe { print($0) }
//    .disposed(by: disposeBag)
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//    Observable<Int>.interval(.milliseconds(300), scheduler: MainScheduler.instance)
//        .take(10)
//        .map { _ in redCircle }
//        .subscribe(onNext: { redSubject.onNext($0) })
//        .disposed(by: disposeBag)
//}
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//    Observable<Int>.interval(.milliseconds(700), scheduler: MainScheduler.instance)
//        .take(10)
//        .map { _ in greenCircle }
//        .subscribe(onNext: { greenSubject.onNext($0) })
//        .disposed(by: disposeBag)
//}
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
//    Observable<Int>.interval(.milliseconds(100), scheduler: MainScheduler.instance)
//        .take(10)
//        .map { _ in blueCircle }
//        .subscribe(onNext: { blueSubject.onNext($0) })
//        .disposed(by: disposeBag)
//}

