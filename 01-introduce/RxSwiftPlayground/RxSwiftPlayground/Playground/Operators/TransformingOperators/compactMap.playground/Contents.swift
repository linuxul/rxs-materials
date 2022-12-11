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
