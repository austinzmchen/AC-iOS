
import Foundation

/*:
 # Hight order function
 
 A higher-order function is simply a function that takes a function as an argument or returns a function as a result, and it may or may not be curried
 [Link](https://stackoverflow.com/questions/18828412/difference-between-currying-and-higher-order-functions)
 */
func twice<T>(_ v: @escaping (T) -> T) -> (T) -> T {
    return { v(v($0)) }
}

// inferred closure
let f = { $0 + 3 }
twice(f)(10) // 16


/*:
 # Curry
 
 A curried function, on the other hand, is one that returns a function as its result. A fully curried function is a one-argument function that either returns an ordinary result or returns a fully curried function. Note that a curried function is necessarily a higher-order function, since it returns a function as its result.
 
 
 */
let xs = 1...100

func addTwo(a: Int) -> Int {
    return a + 2
}
let x = xs.map(addTwo) // x = [3, 4, 5, 6, etc]


func add(a: Int) -> (Int) -> Int {
    return {
        $0 + a
    }
}

add(a: 2)(3)
let y = xs.map(add(a:2)) // x = [3, 4, 5, 6, etc]


/*:
 ## Note
 
 ```
 // implicit
 return {
 $0 + a
 }
 ```
 
 is equivalent to
 
 ```
 let c: (Int) -> Int = {
 $0 + a
 }
 return c
 ```
 */
func add1(a: Int) -> (Int) -> Int {
    let c: (Int) -> Int = {
        $0 + a
    }
    return c
}

