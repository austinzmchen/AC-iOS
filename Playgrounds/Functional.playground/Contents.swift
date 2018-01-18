//: Playground - noun: a place where people can play

import Foundation

let example1 = {
    struct Dog {
        func eat(_ food: String) -> String {
            let r = "ate" + food
            print(r)
            return r
        }
    }
    
    Dog().eat("Dog food")
    
    let eat1 = Dog().eat
    eat1("Dog food1")
    
    let eat2 = { Dog().eat($0) } // $0 is the argument of the '{ }', and implicitly indicates there is one argument to the anonymous closure '{ }'
    eat1("Dog food2")
}()

let example2 = {
    let xs = [1,2,3]
    let ys = ["A","B","C"]
    
    func reversedZip1<T,U>(_ xs: [T], _ ys: [U]) -> Zip2Sequence<ReversedRandomAccessCollection<[T]>, ReversedRandomAccessCollection<[U]>> {
        return zip(xs.reversed(), ys.reversed())
    }
    let zs = reversedZip1(xs, ys)
    dump(zs)
    
    func reversedZip2<T,U>(_ xs: [T], _ ys: [U]) -> AnySequence<(T, U)> {
        return AnySequence( zip(xs.reversed(), ys.reversed()) )
    }
    let zs2 = reversedZip2(xs, ys)
    dump(zs2)
}()

let example3 = {
    
}()
