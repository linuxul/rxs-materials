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
 # combineLatest
 */

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let greetings = PublishSubject<String>()
let languages = PublishSubject<String>()

// observale은 하나의 값을 방출하면 조합을 해서 방출을 하도록 한다.
Observable.combineLatest(greetings, languages) { lhs, rhs -> String in
    return "\(lhs) \(rhs)"
}
.subscribe { print($0) }
.disposed(by: bag)

greetings.onNext("Hi")
languages.onNext("World!")

greetings.onNext("Hello")
languages.onNext("RxSwift")

//greetings.onCompleted()
// 구독자중에 하나라도 에러가 발생을 하면 onError를 받는다.
greetings.onError(MyError.error)

languages.onNext("SwiftUI")
languages.onCompleted()




