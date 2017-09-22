//: Playground - noun: a place where people can play

import UIKit

// Your function or variable must be a static member of a type that returns an instance of that type.


// UIColor
func getColor(_ color: UIColor) {
}

//Instead of calling our function like this:
_ = getColor(UIColor.purple)

//We can omit the UIColor type like this:
_ = getColor(.purple)


// custom
class Cat {
    static let goodCat = Cat()
}

class Human {
    func pet(_ cat: Cat) {
        //...
    }
}

Human().pet(.goodCat)
