//: Playground - noun: a place where people can play

import UIKit

let example1 = {
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

    struct Starship_Simple: Codable {
        var name: String
        var weight: Float
        var capitan: Crew
        var crews: [Crew]
        var speed: Float
    }

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

    // encode
    let crew3 = Crew(name: "Crew Three", age: 22)
    let encoded = try! JSONEncoder().encode(crew3)

    // decode
    let starship0 = try! JSONDecoder().decode(Starship_Simple.self, from: starshipStr.data(using: .utf8)!)
    print(starship0)

    let starship = try! JSONDecoder().decode(Starship.self, from: starshipStr.data(using: .utf8)!)
    print(starship)

    // keypath
    let capitanAge = starship[keyPath: \Starship.capitan.age]
}()




// https://stackoverflow.com/questions/45598461/swift-4-decodable-with-keys-not-known-until-decoding-time
let example2 = {
    struct Category: Decodable {
        struct Detail: Decodable {
            var category: String
            var trailerPrice: String
            var isFavorite: Bool?
            var isWatchlist: Bool?
        }

        var name: String
        var detail: Detail

        struct CodingKeys: CodingKey {
            var intValue: Int?
            var stringValue: String

            init?(intValue: Int) { self.intValue = intValue; self.stringValue = "\(intValue)" }
            init?(stringValue: String) { self.stringValue = stringValue }

            static let kName = CodingKeys(stringValue: "categoryName")!
            static func makeKey(name: String) -> CodingKeys {
                return CodingKeys(stringValue: name)!
            }
        }

        init(from coder: Decoder) throws {
            let container = try coder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .kName)
            self.detail = try container.decode([Detail].self, forKey: .makeKey(name: name)).first!
        }
    }

    let jsonData = """
      [
        {
          "categoryName": "Trending",
          "Trending": [
            {
              "category": "Trending",
              "trailerPrice": "",
              "isFavourite": null,
              "isWatchlist": null
            }
          ]
        },
        {
          "categoryName": "Comedy",
          "Comedy": [
            {
              "category": "Comedy",
              "trailerPrice": "",
              "isFavourite": null,
              "isWatchlist": null
            }
          ]
        }
      ]
    """.data(using: .utf8)!

    let categories = try! JSONDecoder().decode([Category].self, from: jsonData)
    print(categories)
}()


let example3 = {
    let jsonData2 = """
    {
        "updatedIntent": {
            "name": "intent_all",
            "confirmationStatus": "NONE",
            "slots": {
                "sendToWho": {
                    "name": "sendToWho",
                    "confirmationStatus": "NONE"
                }
            }
        }
    }
    """

    struct UpdatedIntent: Encodable {
        var name: String
        var confirmationStatus: String
        var slots: Slots
    }

    struct Slots: Encodable {
        var _slots: [Slot]
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys2.self)
            for s in _slots {
                try container.encode(s, forKey: CodingKeys2.makeKey(name: s.name))
            }
        }
    }

    struct Slot: Encodable {
        var name: String
        var confirmationStatus: String
        var value: String?
        
        public init(name: String, confirmationStatus: String, value: String?) {
            self.name = name
            self.confirmationStatus = confirmationStatus
            self.value = value
        }
    }

    struct CodingKeys2: CodingKey {
        var intValue: Int?
        var stringValue: String
        
        init?(intValue: Int) { self.intValue = intValue; self.stringValue = "\(intValue)" }
        init?(stringValue: String) { self.stringValue = stringValue }
        
        static let kName = CodingKeys2(stringValue: "categoryName")!
        static func makeKey(name: String) -> CodingKeys2 {
            return CodingKeys2(stringValue: name)!
        }
    }

    let s1 = Slot(name: "sendToWho", confirmationStatus: "NONE", value: "draw")
    let s2 = Slot(name: "messageType", confirmationStatus: "NONE", value: nil)
    let ss = Slots(_slots: [s1, s2])

    let ui = UpdatedIntent(name: "intent_all", confirmationStatus: "NONE", slots: ss)

    let d = try! JSONEncoder().encode(ui)
    let ds = String(data: d, encoding: .utf8)
    print(ds)
}()
