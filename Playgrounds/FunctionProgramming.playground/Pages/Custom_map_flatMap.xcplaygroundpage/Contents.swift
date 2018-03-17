
//: Playground - noun: a place where people can play
import Foundation

enum Result<A> {
    case success(A)
    case error(Error)
    
    init(_ value: A?, or error: Error) {
        if let value = value {
            self = .success(value)
        } else {
            self = .error(error)
        }
    }
}
extension String: Error { }

extension Result {
    // map takes transform function that returns B, to return Result<B>
    func map<B>(_ transform: (A) -> B) -> Result<B> {
        switch self {
        case .success(let value): return .success(transform(value))
        case .error(let error): return .error(error)
        }
    }
    
    // flatMap takes transform function that returns Result<B>, to return Result<B>
    func flatMap<B>(_ transform: @escaping (A) -> Result<B>) -> Result<B> {
        switch self {
        case .success(let value):
            return transform(value)
        case .error(let e):
            return .error(e)
        }
    }
}

// Optional FlapMap
/*
 func map<U>((Wrapped) -> U)ƒ
 
 func flatMap<U>((Wrapped) -> U?)
 */

let r: Result<String> = .success("Hello")
let a = r.flatMap{ .success($0 + " world") }
let a2 = r.flatMap{ _ in return Result<String>.error("error") }
let b = r.map{$0 + "Austin"}
