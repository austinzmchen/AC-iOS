//: Playground - noun: a place where people can play

import Foundation

/*:
 ## Nested Ternary notation
 */
let b0 = false; let b1 = false; let b2 = true; let b3 = false;

let b = b0 ? "some stuff 1"
    : b1 ? "some stuff 2"
    : b2 ? "some stuff 3"
    : b3 ? "some stuff 4"
    : "ac"

let d1 = true ? { print("print something") } : { print("print something else") }
d1()

let d2 = true ? { print("print something 2") } :{}
d2()

let e0 = 3
let e1: String = {
    switch e0 {
    case 1: return "switch something 1"
    case 2: return "switch something 2"
    case 3: return "switch something 3"
    default: return "switch default"
    }
}()
print(e1)

/*:
 ## Auto Closure
 */

// set up
private let isDebug = false
func someCondition() -> Bool {
    print("someCondition")
    return true
}

// example
func assert(_ expression: @autoclosure () -> Bool,
            _ message: @autoclosure () -> String) {
    guard isDebug else {
        return
    }
    
    // Inside assert we can refer to expression as a normal closure
    if !expression() {
        assertionFailure(message())
    }
}

// If assert was implemented using “normal” closures you’d have to use it like this:
// assert({ someCondition() }, { "Hey, it failed!" })

assert(someCondition(), "Hey it failed!")
