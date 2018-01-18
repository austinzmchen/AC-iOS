//: Playground - noun: a place where people can play

import Foundation

// An Animal can eat
protocol Animal {
    associatedtype Food
    func feed(food: Food)
}

// Kinds of Food
struct Grass {}
struct Worm {}

struct Cow: Animal {
    func feed(food: Grass) { print("moo") }
}

struct Goat: Animal {
    func feed(food: Grass) { print("bah") }
}

struct Bird: Animal {
    func feed(food: Worm) { print("chirp") }
}

// let grassEaters: [Animal] = [Cow(), Goat()] // Protocol 'Animal' can only be used as a generic constraint because it has Self or associated type requirements

struct AnyAnimal<Food>: Animal {
    private let _feed: (Food) -> Void
    init<Base: Animal>(_ base: Base) where Food == Base.Food {
        _feed = base.feed
    }
    func feed(food: Food) { _feed(food) }
}

let grassEaters = [AnyAnimal(Cow()), AnyAnimal(Goat())] // Type is [AnyAnimal<Grass>]

let mixedEaters = [AnyAnimal(Cow()), AnyAnimal(Bird())] // error: type of expression is ambiguous without more context
