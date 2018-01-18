//: let vs var

let view = UIView()
view = view1 // build error, because let only allow variable be assigned once
view.alpha = 0.5  // Will this line compile? Yes, because let on reference-semantic variable allow change property

let origin = CGPoint(x: 0, y: 0)
origin.x = 10 // build error, because let on value-semantic variable does not allow property change

/*: Struct vs Class:

In Swift, many basic data types such as String, Array, and Dictionary are implemented as structures. This
means that data such as strings, arrays, and dictionaries are copied when they are assigned to a new constant or variable, or when they are passed to a function or method.

Foundation: NSString, NSArray, and NSDictionary are implemented as classes, not structures. Strings, arrays, and dictionaries in Foundation are always assigned and passed around as a reference to an existing instance, rather than as a copy.

Abbreviation of brackets:
    
    if (a > b){}
vs
if a > b {} // works in swift
 
 */

/*: Optionals:

? meaning maybe nil

public var window: UIWindow? = UIWindow(frame:CGRectMake(0, 0, UIScreen.mainScreen().bounds.height, UIScreen.mainScreen().bounds.width))

window can be nil.

let a = b?.someMethod()
a is automatically a optional type because it can be nil

optional type:
Int, String, UIView etc, Unlike objec, a variable of Int, String or other type, can not be nil
Int? is a different type from Int

try to think of Int? as either nil or a wrapped up Int variable, of which the wrapped up value is unknown until unwrapped.

(!) Unwrapping:
! meaning unwrapping to non-nil value or throw exception

func double(x: Int) -> Int {
    return 2 * x
}

let y: Int? = .Some(42)
println(double(y)) // error: Value of optional type 'Int?' not unwrapped

Because Int is different find Int? so we can not pass y to double(), unless we pass y!

Optional Chaining:
let y: Int? = someObject?.someProperty?.someInt()

Optional Binding:
    
    if let y: Int? = someObject.someInt() {
    println(double(y))
} else {
    println("No value to double!") // prints "No value to double!"
}

We get unwrapped y for free with optional binding.

You can also bind multiple entries in the same if statement. What’s more is that later entries can rely on the earlier ones being successfully un-wrapped.

let urlString1: String? = "http://..."
if let str = someString where str.characters.count == 5 && str.characters.contains("h"),
    let url = NSURL(string: str), // need 'let' here because 'where' cuts off the batch definitions
    data = NSData(contentsOfURL: url), // can optionally add 'let' the beginning of this line
    image = UIImage(data: data) // can optionally add 'let' the beginning of this line
{
    let view = UIImageView(image: image)
}

If you need to perform a check before performing various if-let bindings, you can supply a leading boolean condition.

let isReady: Bool = false
if isReady, // can perform check before optinal binding
    let str = someString where str.characters.count == 5 && str.characters.contains("h")
{}

Scoping:

Suppose someString is a placeholder for a verbose line of code which needs to be reduced with a

func funcError() {
    if let a = someString {
        // do something with a
    } else {
        // can't something else with a
    }
    // can't other things with a
}

Solution:

func funcSuccess() {
    let a = someString
    if let b = a  {
        // do something with b, thus a
    } else {
        // do something else with a?
    }
    // do other things with a?
}


(as! / as?)  casting:
for upcasting, such as cast Dog type to Animal type. Upcasting always succeed.
let a: Dog
let b = a as Animal

for downcast, down casting works only for the object which are created in original type and casted to a type that equals or higher than the original type.
let a: Animal
let b = a as Dog // compile error

so the solution is
let b = a as? Dog // b = nil is downcast failed

or
let b = a as! Dog // force downcast, runtime error if cast failed

let build = NSBundle.mainBundle().infoDictionary?["CFBundleVersion"] as! String?
run-time error is bundle version is e.g. Int type.
if bundle version is nil, build will also be nil

http://lithium3141.com/blog/2014/06/19/learning-swift-optional-types/
https://developer.apple.com/swift/blog/?id=23

Objc can check casting success or failure by checking if the castee isKindOf to-be-casted type.

Any, AnyObject or NSObject:

NSObject represent a foundation class
    
AnyObject can represent a instance of any class, like id in ObjC. id is a pointer to any type, but unlike void * it always points to an Objective-C object.

Any can represent any type, thus a union of AnyObject and primitive type, including functional types.


_ used to modify external parameter name behavior for methods

func foo(s1: String, s2: String) -> String {
    return s1 + s2;
}
bar.foo("Hello", s2: "World")

Abbreviate second parameter external name:

func foo(s1: String, _ s2: String) -> String {
    return s1 + s2;
}
bar.foo("Hello", "World")

What does underscore before first parameter do?

func foo(_ s1: String, s2: String) -> String {
    return s1 + s2;
}

so basically, it does this for no reason and just confuses everybody. awesome. – botbot Dec 4 '14 at 9:02

Getter or setter:

var center:Int {
    willSet (aCenter) {
        print("\(aCenter) or \(newValue)")
    }
    didSet {
        print("\(oldValue)")
    }
}

Below is Computed property, kinda like method disguised as property to swizzle value

var center:Int {
    get {
        // calling ‘center’ with result recursive call self, stack over flow
        return x * 10
    }
    set {
        center = center + 2
    }
}

Protocol where clause:

protocol Feline {
    func meow() -> String
}

class SmallCats {}
class BigCats {}

extension SmallCats: Feline { // the object has to be SmallCats, and confirms to Feline
    func meow() -> String {
        return "meow"
    }
}

extension Feline where Self: BigCats { // allows other base class of Feline
    func meow() -> String {
        return "grrrr"
    }
}

class DomesticShortHair: SmallCats {}
class Tiger: BigCats, Feline {}


SmallCats().meow() // “meow"
DomesticShortHair().meow() // “meow"

BigCats.meow() // build error, meow method not found
Tiger().meow() // “grrrr"


Delegate pattern syntax:

weak var delegate: SomeDelegate?

At this point, we have to use a class protocol to mark the delegate property as weak by having our protocol inherit :class

@objc protocol SomeDelegate: class { //The protocol now inherits class
    @optional func DataWillRead()
    func DataWillRead()
}

// somewhere in the path
delegate?.DataWillRead?()      // Optional method check
data = _createData()
delegate?.DataDidRead()        // Required method check


http://www.thinkandbuild.it/from-objective-c-to-swift/
