//: Playground - https://oleb.net/blog/2016/11/rawrepresentable/

import UIKit

// RawRepresentable

// Can’t use the shorthand syntax for UIColor raw values
enum Color {
    case red
    case green
    case blue
}

// But it’s no problem with manual RawRepresentable conformance
extension Color: RawRepresentable {
    typealias RawValue = UIColor
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case UIColor.red: self = .red
        case UIColor.green: self = .green
        case UIColor.blue: self = .blue
        default: return nil
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case .red: return UIColor.red
        case .green: return UIColor.green
        case .blue: return UIColor.blue
        }
    }
}

print(Color.red.rawValue)
print(type(of: Color.red).RawValue.self)
