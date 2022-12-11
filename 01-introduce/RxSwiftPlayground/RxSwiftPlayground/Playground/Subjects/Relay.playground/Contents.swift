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
import RxCocoa

/*:
 # Relay
 */
// PublishRelay - PublishSubject - Next이벤트만 전달을 한다. 종료가 되지 않고, dispose가 될때 종료를 하도록 한다.
// BehaviorRelay - BehaviorSubject - Next이벤트만 전달을 한다. 종료가 되지 않고, dispose가 될때 종료를 하도록 한다.

let disposeBag = DisposeBag()

let prelay = PublishRelay<Int>()

prelay.subscribe { print("publishRelay : \($0)") }
.disposed(by: disposeBag)

prelay.accept(1)
prelay.accept(2)

let brelay = BehaviorRelay<Int>(value: 2)
brelay.accept(3)

brelay.subscribe {
    print("behaviorRelay : \($0)")
}.disposed(by: disposeBag)

brelay.accept(4)


print(brelay.value)


let rreplay = ReplayRelay<Int>.create(bufferSize: 3)
(1...10).forEach {
    rreplay.accept($0)
}

rreplay.subscribe {
    print("replayRelay : \($0)")
}
.disposed(by: disposeBag)



