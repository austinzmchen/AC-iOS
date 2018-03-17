
import UIKit

/*:
 Swift 4 has added support for representing a type as a class that conforms to a protocol. The syntax is Class & Protocol. Here is some example code using this concept from "What's New in Swift" (session 402 from WWDC 2017):
 
 [link 1](https://ianmcdowell.net/blog/playground-books/)
 
 [link 2](https://www.hackingwithswift.com/swift4)
 */

protocol STCMTSubViewControllerType {
    var collectionId: Int64? {get set}
}

let viewControllers: [UIViewController & STCMTSubViewControllerType] = []


/*:
 Numeric literals
 */

let decimal = 42        // 42 = 4 * 10 + 2 * 1
let binary = 0b101010   // 42 = 1 * 32 + 1 * 8 + 1 * 2
let octal = 0o52        // 42 = 5 * 8 + 2 * 1
let hexadecimal = 0x2A  // 42 = 2 * 16 + 10 * 1

let earthPopulation = 7_100_000_000 //  improve the readability of long numbers
let thirtyTwoHundred = 32_00


//: ExpressibleByStringLiteral

struct HelloStruct {
    var a: String
    var b: String
}

extension HelloStruct: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self = HelloStruct(a: value, b: value)
    }
}

let a = HelloStruct(a: "a", b: "a")
let b: HelloStruct = "b"
print(b)
