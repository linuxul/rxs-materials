import UIKit
import RxSwift

example(of: "Single") {

    // 1
    let disposeBag = DisposeBag()

    // 2
    enum FileReadError: Error {
        case fileNotFound, unreadable, encodingFailed
    }

    // 3
    func loadText(from name: String) -> Single<String> {
        // 4
        return Single.create { single in
            print("create")

            // 1
            let disposeable = Disposables.create()

            // 2
            guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
                print("fileNotFound")
                single(.failure(FileReadError.fileNotFound))
                return disposeable
            }

            // 3
            guard let data = FileManager.default.contents(atPath: path) else {
                print("unreadable")
                single(.failure(FileReadError.unreadable))
                return disposeable
            }

            // 4
            guard let contents = String(data: data, encoding: .utf8) else {
                print("encodingFailed")
                single(.failure(FileReadError.encodingFailed))
                return disposeable
            }

            print("success")
            // 5
            single(.success(contents))
            return disposeable
        }
    }

    // 1
    loadText(from: "Copyright")
    // 2
        .subscribe {
            //3
            switch $0 {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
        .disposed(by: disposeBag)


}


print("End")
