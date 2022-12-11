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
 # skip(until:)
 */

let disposeBag = DisposeBag()


//이 시퀀스에 skipUntil을 걸고, 다른 시퀀스를 전달해주면 어떻게 될까? (다른 시퀀스는 trigger 시퀀스라고 하자.)
//결과는, Trigger시퀀스의 이벤트가 발생할 때 까지, 원래 시퀀스의 모든 이벤트가 skip된다.

let subject = PublishSubject<Int>()
let trigger = PublishSubject<Int>()

subject.skip(until: trigger)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(1)
trigger.onNext(0)

subject.onNext(11)

