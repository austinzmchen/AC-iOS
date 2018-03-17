
//: back tick ` make allow overloading local variable names

class Exmaple {
    func doSomething() {}
    
    var f: Bool {
        let closure: () -> Bool = { [weak self] in
            guard let `self` = self else { return false }
            self.doSomething()
            return true
        }
        return closure()
    }
}

