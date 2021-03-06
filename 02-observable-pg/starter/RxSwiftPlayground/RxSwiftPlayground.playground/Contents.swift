//: Please build the scheme 'RxSwiftPlayground' first
import RxSwift
import UIKit
import Foundation

//

/*:
 Copyright (c) 2014-2017 Razeware LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

example(of: "just, of, from") {
    // 1
    let one = 1
    let two = 2
    let three = 3
    
    // 2
    let observable: Observable<Int> = Observable<Int>.just(one)
    
    let observable2 = Observable.of(one, two, three)
    
    let observable3 = Observable.of([one, two, three])
    
    let observable4 = Observable.from([one, two, three])
    
//    let observer = NotificationCenter.default.addObserver(
//        forName: .UIKeyboardDidChangeFrame,
//        object: nil,
//        queue: nil)
//    { notification in
//
//    }
    
}

example(of: "subscribe") {
    let one = 1
    let two = 2
    let three = 3
    
    let observable = Observable.of(one, two, three)
    
//    observable.subscribe { (event) in
//        if let element = event.element {
//            print(element)
//        }
//    }
    
    observable.subscribe(onNext: { element in
        print(element)
    })
}

example(of: "empty") {
    let observable = Observable<Void>.empty()
    
    observable.subscribe(
        onNext: { element in
            print(element)
    },
        onCompleted: {
            print("Completed")
    }
    )
}

example(of: "never") {
    let observable = Observable<Any>.never()
    
    observable
        .subscribe(
            onNext: { (element) in
                print(element)
        },
            onCompleted: {
                print("Completed")
        }
    )
}

example(of: "range") {
    let observable = Observable<Int>.range(start: 1, count: 10)
    
    observable
        .subscribe(
            onNext: { i in
                let n = Double(i)
                let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) / 2.23606).rounded())
                print(fibonacci)
        }
    )
}

example(of: "dispose") {
    let observable = Observable.of("A", "B", "C")
    
    let subscription = observable.subscribe { (event) in
        print(event)
    }
    subscription.dispose()
}

example(of: "DisposeBag") {
    let disposeBag = DisposeBag()
    
    Observable.of("A", "B", "C")
        .subscribe {
            print($0)
    }
    .disposed(by: disposeBag)
}

example(of: "create") {
    let disposeBag = DisposeBag()
    
    Observable<String>.create { (observer) -> Disposable in
        observer.onNext("1")
        observer.onCompleted()
        observer.onNext("?")
        return Disposables.create()
    }
    .subscribe(
        onNext: { print($0) },
        onError: { print($0) },
        onCompleted: { print("Completed") },
        onDisposed: { print("Disposed") }
    )
        .disposed(by: disposeBag)
}
