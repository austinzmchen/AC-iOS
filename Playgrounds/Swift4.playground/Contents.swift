//: Playground - noun: a place where people can play

// https://www.hackingwithswift.com/swift4

import UIKit

var starshipStr = """
    {
        "name": "Vulcan",
        "capitan": {
            "name": "Paul",
            "age": 44
        },
        "crews": [
            {
                "name": "Crew One",
                "age": 30
            },
            {
                "name": "Crew Two",
                "age": 22
            }
        ],
        "weight": 10,
        "speed": 100
    }
    """

struct Starship: Codable {
    var name: String
    var weight: Float
    var capitan: Crew
    var crews: [Crew]
    
    var capitanAge: Float
    
    enum CodingKeys: String, CodingKey {
        case name, weight, capitan, crews, capitanAge = "speed"
    }
}

struct Crew: Codable {
    var name: String
    var age: Int
}

let crew3 = Crew(name: "Crew Three", age: 22)
let encoded = try! JSONEncoder().encode(crew3)

let starship = try! JSONDecoder().decode(Starship.self, from: starshipStr.data(using: .utf8)!)

// keypath
let capitanAge = starship[keyPath: \Starship.capitan.age]



/*
 Swift 4 has added support for representing a type as a class that conforms to a protocol. The syntax is Class & Protocol. Here is some example code using this concept from "What's New in Swift" (session 402 from WWDC 2017):
 */

protocol STCMTSubViewControllerType {
    var collectionId: Int64? {get set}
}

let viewControllers: [UIViewController & STCMTSubViewControllerType] = []
