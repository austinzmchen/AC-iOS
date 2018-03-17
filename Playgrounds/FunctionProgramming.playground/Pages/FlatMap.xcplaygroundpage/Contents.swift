//: Playground - noun: a place where people can play

import Foundation

// example 1
let sections = [
    [1, 2],
    [3, 4, 5],
    [6, 7, 8, 9],
]

let s1 = sections.map{ section in
    return section.map{ row in
        return String(row)
    }
}
print( Array(s1.joined()) )

let s2 = sections.flatMap{ section in
    return section.map{ row in
        return String(row)
    }
}
print(s2)

// example 2

struct User {
    var name: String
    var pets: [Pet]
}

struct Pet {
    var type: String
    var doctors: [String]
}

let users = [
    User(name: "Scott", pets: [
        Pet(type: "Dog", doctors: ["Bob", "Luke"]),
        Pet(type: "Snake", doctors: ["Kim", "John"]),
        Pet(type: "Bird", doctors: ["Marry"])
        ]),
    User(name: "Jason", pets: [
        Pet(type: "Cat", doctors: ["Austin", "Ed"]),
        Pet(type: "Monkey", doctors: ["Mei", "David"])
        ])
]

let allUserPets = users.flatMap {
    $0.pets
}
print(allUserPets)

var allDocs1: [String] = []
users.map({
    $0.pets.map {
        allDocs1.append(contentsOf: $0.doctors)
    }
})

print(allDocs1)


var allDocs2: [String] = users.flatMap {
    $0[keyPath: \User.pets].flatMap {
        $0[keyPath: \Pet.doctors]
    }
}

print(allDocs2)
