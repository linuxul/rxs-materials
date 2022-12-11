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
 # interval
 */
// 지정된 주기마다 정수를 방출하는 interval 연산자에 대해 공부합니다.

let i = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
let s1 = i.subscribe { print("1 >> \($0)") }

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    s1.dispose()
}


var s2: Disposable?
DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    s2 = i.subscribe { print("2 >> \($0)") }
}

DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
    s2?.dispose()
}
