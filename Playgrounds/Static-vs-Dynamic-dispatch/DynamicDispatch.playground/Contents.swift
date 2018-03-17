//: You use the @objc attribute along with the dynamic modifier to require that access to members be dynamically dispatched through the Objective-C runtime.

/*
 https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/InteractingWithObjective-CAPIs.html
 https://developer.apple.com/swift/blog/?id=27
 */

import Foundation

class A { // swift object
    @objc dynamic func method1() { print("A") }
}

class B: A {
}
extension B {
    override func method1() { print("B") }
}

B().method1()

class C: NSObject { // NSObject
}
extension C {
    @objc dynamic func method2() { print("C") }
}

class D: C {
    override func method2() { print("D") }
}

D().method2()
