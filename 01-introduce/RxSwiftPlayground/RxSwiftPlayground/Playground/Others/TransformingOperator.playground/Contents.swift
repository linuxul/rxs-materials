import UIKit
import RxSwift
import RxRelay

// 1
enum MyError: Error {
    case anError
}

// 2
func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, (event.element ?? event.error) ?? event)
}

// 개별 요소를 Collection으로 변환을 할 경우
example(of: "toArray") {
    // 1
    let disposeBag = DisposeBag()

    // 2
    Observable.of("A", "B", "C")
        .toArray()
        .subscribe(onSuccess: {
            print("onSuccess = \($0)")
        }, onFailure: { failure in
            print("onFailure = \(failure)")
        }, onDisposed: {
            print("onDisposed")
        })
        .disposed(by: disposeBag)

}


// 데이터를 변형 시킴
example(of: "map") {
    // 1
    let disposeBag = DisposeBag()

    // 2
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut

    // 3
    Observable.of(123, 4, 56)
        .map {
            formatter.string(for: $0) ?? ""
        }
        .subscribe(
            onNext: { event in
                print("event = \(event)")
            },
            onError: { error in
                print("onError \(error)")
            },
            onCompleted: {
               print("onCompleted")
            },
            onDisposed: {
               print("onDisposed")
            }
        )
        .disposed(by: disposeBag)

}

// 각 요소를 튜플의 형식으로 생성을 하도록 한다.
example(of: "enumerated and map") {
    // 1
    let disposeBag = DisposeBag()

    // 3
    Observable.of(1, 2, 3, 4, 5, 6)
        .enumerated()
        .map { index, integer in
            index > 2 ? integer * 2 : integer
        }
        .subscribe(
            onNext: { event in
                print("event = \(event)")
            },
            onError: { error in
                print("onError \(error)")
            },
            onCompleted: {
               print("onCompleted")
            },
            onDisposed: {
               print("onDisposed")
            }
        )
        .disposed(by: disposeBag)
}

// nil을 필터링 처리를 하도록 한다.
example(of: "compactMap") {
    // 1
    let disposeBag = DisposeBag()

    // 2
    Observable.of("To", "be", nil, "or", "not", "to", "be", nil)
        .compactMap { $0 }
        .toArray()
        .map { $0.joined(separator: " ") }
        .subscribe(onSuccess: {
            print("Success = \($0)")
        })
        .disposed(by: disposeBag)

}


struct Student {
    let score: BehaviorSubject<Int>
}


example(of: "flatMap") {
    let disposeBag = DisposeBag()

    // 1
    let laura = Student(score: BehaviorSubject(value: 80))
    let charlotte = Student(score: BehaviorSubject(value: 90))

    // 2
    let student = PublishSubject<Student>()

    // 3
    student
        .flatMap {
            $0.score
        }
        .subscribe(
            onNext: {
                print("Student = \($0)")
            }
        )
        .disposed(by: disposeBag)

    student.onNext(laura)
    laura.score.onNext(85)
    student.onNext(charlotte)
    laura.score.onNext(95)
    charlotte.score.onNext(100)

}



example(of: "flatMapLatest") {
    let disposeBag = DisposeBag()

    // 1
    let laura = Student(score: BehaviorSubject(value: 80))
    let charlotte = Student(score: BehaviorSubject(value: 90))

    // 2
    let student = PublishSubject<Student>()

    // 3
    student
        .flatMapLatest {
            $0.score
        }
        .subscribe(
            onNext: {
                print("Student = \($0)")
            }
        )
        .disposed(by: disposeBag)

    student.onNext(laura)
    laura.score.onNext(85)
    student.onNext(charlotte)

    // 1
    laura.score.onNext(95)
    charlotte.score.onNext(100)

}



example(of: "materialize and dematerialize") {
    let disposeBag = DisposeBag()

    // 1
    let laura = Student(score: BehaviorSubject(value: 80))
    let charlotte = Student(score: BehaviorSubject(value: 100))

    // 2
    let student = BehaviorSubject(value: laura)

    // 3
    let studentScore = student
        .flatMapLatest {
            $0.score
        }

    studentScore
        .subscribe(
            onNext: {
                print("Student = \($0)")
            }
        )
        .disposed(by: disposeBag)

    laura.score.onNext(85)
    laura.score.onError(MyError.anError)
    laura.score.onNext(90)

    student.onNext(charlotte)
}


example(of: "materialize and dematerialize #1") {
    let disposeBag = DisposeBag()

    // 1
    let laura = Student(score: BehaviorSubject(value: 80))
    let charlotte = Student(score: BehaviorSubject(value: 100))

    // 2
    let student = BehaviorSubject(value: laura)

    // 3
    let studentScore = student
        .flatMapLatest {
            $0.score.materialize()
        }

    studentScore
        .subscribe(
            onNext: {
                print("Student = \($0)")
            }
        )
        .disposed(by: disposeBag)

    laura.score.onNext(85)
    laura.score.onError(MyError.anError)
    laura.score.onNext(90)

    student.onNext(charlotte)
}



example(of: "materialize and dematerialize #2") {
    let disposeBag = DisposeBag()

    // 1
    let laura = Student(score: BehaviorSubject(value: 80))
    let charlotte = Student(score: BehaviorSubject(value: 100))

    // 2
    let student = BehaviorSubject(value: laura)

    // 3
    let studentScore = student
        .flatMapLatest {
            $0.score.materialize()
        }

    studentScore
        .filter {
            guard $0.error == nil else {
                print($0.error!)
                return false
            }
            return true
        }
        .dematerialize()
        .subscribe(
            onNext: {
                print($0)
            })
        .disposed(by: disposeBag)

    laura.score.onNext(85)
    laura.score.onError(MyError.anError)
    laura.score.onNext(90)

    student.onNext(charlotte)
}


