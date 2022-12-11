//
//  SupportCode.swift
//  RxSwiftPlayground
//
//  Created by linuxul on 2022/12/11.
//

import Foundation
import RxSwift
import RxRelay

// 1
public enum MyError: Error {
    case anError
}

// 2
public func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, (event.element ?? event.error) ?? event)
}

public func example(of description: String, action: () -> Void) {
    print("\n --- Example of: \(description) ---")
    action()
}

