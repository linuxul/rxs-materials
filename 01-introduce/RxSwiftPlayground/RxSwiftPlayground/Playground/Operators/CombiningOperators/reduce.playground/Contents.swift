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
 # reduce
 */

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let o = Observable.range(start: 1, count: 5)

print("== scan")

// 중간 결과와 최종결과를 모두 방출을 하도록 한다.
o.scan(0, accumulator: +)
   .subscribe { print($0) }
   .disposed(by: bag)

print("== reduce")

// 시드 값과 옵저버블이 방출하는 요소를 대상으로 클로저를 실행하고 최종 결과를 옵저버블로 방출하는 reduce 연산자에 대해 공부합니다.
// 결과 값만 방출을 하도록 한다.
o.reduce(0, accumulator: +)
    .subscribe { print($0) }
    .disposed(by: bag)







