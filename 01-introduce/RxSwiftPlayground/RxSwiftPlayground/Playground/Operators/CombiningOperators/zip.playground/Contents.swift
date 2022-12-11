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
 # zip
 */

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let numbers = PublishSubject<Int>()
let strings = PublishSubject<String>()

// Indexed Sequencing을 구현하는 zip 연산자에 대해 공부합니다.
// 두 observable은 모두 같은 인텍스를 방출해야 결합해서 방출을 하도록 한다.
// 결합의 짝이 없으면 방출하지 않는다.

Observable.zip(numbers, strings) { "\($0) - \($1)" }
.subscribe { print($0) }
.disposed(by: bag)

numbers.onNext(1)
strings.onNext("one")

numbers.onNext(2)
strings.onNext("two")

// 하나의 completed 이벤트가 전달이 되면 나중의 것은 방출하지 않는다.
numbers.onCompleted()
strings.onNext("three")

// 구독자 중에 error를 하나라도 방출을 하게 되면 구독자를 에러를 방출하도록 된다.
strings.onError(MyError.error)




