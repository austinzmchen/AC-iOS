//: Playground - noun: a place where people can play

import UIKit

protocol Drawable {
    func draw()
}

struct Diagram: Drawable {
    var items: [Drawable] = []
    func draw() {}
}

//: Use Reference
struct BezierPath: Drawable {
    var path = UIBezierPath() // reference type
    
    func draw() {}
    
    var isEmpty: Bool {
        return path.isEmpty
    }
    
    func addLine(to point: CGPoint) {
        path.addLine(to: point)
    }
}


let bPath = BezierPath()

let bPath2 = bPath
bPath2.addLine(to: CGPoint(x: 0, y: 0))

// both bPath.path and bPath2.path shares the same path object
print(bPath.path)
print(bPath2.path)

//: Use Copy - by copy-on-write
struct BezierPathNew: Drawable {
    var _path = UIBezierPath()
    
    func draw () {}
    
    var pathForReading: UIBezierPath {
        return _path
    }
    
    var pathForWriting: UIBezierPath {
        mutating get { // mutating keyword is required to assign new value to property
            _path = _path.copy() as! UIBezierPath
            return _path
        }
    }
}

extension BezierPathNew {
    var isEmpty: Bool {
        return pathForReading.isEmpty
    }
    
    mutating func addLine(to point: CGPoint) {
        pathForWriting.addLine(to: point)
    }
}

let bPathNew = BezierPathNew()

var bPathNew2 = bPathNew // need to use var because let makes it immutable
bPathNew2.addLine(to: CGPoint(x: 0, y: 0)) // here is where a new _path is created
print(bPathNew._path)
print(bPathNew2._path)


//: problem where copy-on-write causes a performance issue

struct Polygon: Equatable {
    var corners: [CGPoint] = []
    
    public static func ==(lhs: Polygon, rhs: Polygon) -> Bool {
        return true
    }
}

extension Polygon {
    var path: BezierPath {
        let result = BezierPath()
        for point in corners {
            result.addLine(to: point) // copies every iteration
        }
        return result
    }
}

//: fix performance issue problem

extension Polygon {
    var pathNew: BezierPath {
        let result = UIBezierPath()
        for point in corners {
            result.addLine(to: point)
        }
        return BezierPath(path: result)
    }
}

//: copy only if not uniquelyReferenced

struct MyWrapper {
    var _object: UIView
    var objectForWriting: UIView {
        mutating get {
            if !isKnownUniquelyReferenced(&_object) {
                _object = _object.copy() as! UIView
            }
            return _object
        }
    }
}

