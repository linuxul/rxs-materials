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
 # BehaviorSubject
 */
// subscribe가 발생하면, 발생한 시점 이전에 발생한 이벤트 중 가장 최신의 이벤트를 전달받는다.


let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}

let p1 = PublishSubject<Int>()
p1.subscribe { print("PublishSubject >> ", $0) }
.disposed(by: disposeBag)
p1.onNext(2)

let b1 = BehaviorSubject<Int>(value: 0)
b1.subscribe { print("BehaviorSubject1 >> ", $0) }
.disposed(by: disposeBag)

b1.onNext(100)

b1.subscribe { print("BehaviorSubject2 >> ", $0) }
.disposed(by: disposeBag)

b1.onNext(200)

b1.subscribe { print("BehaviorSubject2-1 >> ", $0) }
.disposed(by: disposeBag)

b1.onCompleted()

b1.subscribe { print("BehaviorSubject3 >> ", $0) }
.disposed(by: disposeBag)






