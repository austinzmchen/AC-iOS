//: In Swift - extension methods can neither override or be overriden

import Foundation

class A { // swift object
    func method1() { print("A") }
}

class B: A {
}
extension B {
    override func method1() { print("B") }
}

//B().method1()

class C: NSObject { // NSObject
}
extension C {
    func method2() { print("C") }
}

class D: C {
    override func method2() { print("D") }
}

//D().method2()

