
import UIKit
import RxSwift

/*:
 # Sharing Subscriptions
 */

let bag = DisposeBag()

let source = Observable<String>.create { observer in
    let url = URL(string: "https://kxcoding-study.azurewebsites.net/api/string")!
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let data = data, let html = String(data: data, encoding: .utf8) {
            observer.onNext(html)
        }
        
        observer.onCompleted()
    }
    task.resume()
    
    return Disposables.create {
        task.cancel()
    }
}
.debug()
.share()



source.subscribe().disposed(by: bag)
source.subscribe().disposed(by: bag)
source.subscribe().disposed(by: bag)









