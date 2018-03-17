
import Foundation

//: The map function transforms an optional into another type in case it's not nil, and otherwise it just returns nil. It does this by taking a closure as parameter.
_={
    var value: Int? = 2
    var newValue = value.map { $0 * 2 }
    // newValue is now Optional(4)
    
    value = nil
    newValue = value.map { $0 * 2 }
    // newValue is now nil
}()

//: The flatMap is pretty much the same as map, except that the return value of the closure in map is not allowed to return nil, while the closure of flatMap can return nil.ƒ
_={
    let value: Double? = 10
    var newValue: Double? = value.flatMap { v in
        if v < 5.0 {
            return nil
        }
        return v / 5.0
    }
    // newValue is now Optional(2)
    
    newValue = newValue.flatMap { v in
        if v < 5.0 {
            return nil
        }
        return v / 5.0
    }
    // now it's nil
}()
