/*:
 ## There are two ways to make a protocol generic:
 
 - By adding a Self Requirement
 - By using Associated Types
 
 https://dispatchswift.com/generic-protocols-in-swift-b47414e29bba
 */

import UIKit

//: ## Protocols with Self requiremen

protocol GenericSelfProtocol {
    func doAllTheThings(_ with: Self)
}

class SomeClass: GenericSelfProtocol {
    func doAllTheThings(_ with: SomeClass) {
        // Do something
    }
}

let someObject = SomeClass()
let oneOtherObject = SomeClass()
someObject.doAllTheThings(oneOtherObject)

//: ## Associated Types

protocol Shareable {
    associatedtype Site
    func shareArticleOn(_ site:Site)
}

struct ThinkPiece: Shareable {
    typealias Site = String
    
    func shareArticleOn(_ site: Site) {
        print("sharing article on \(site)")
    }
}

let thinkPiece = ThinkPiece()
thinkPiece.shareArticleOn("LinkedIn")

struct ClickBait: Shareable {
    typealias Site = [String]
    
    func shareArticleOn(_ sites: Site) {
        for site in sites {
            print("sharing article on \(site)")
        }
    }
}

let clickBait = ClickBait()
clickBait.shareArticleOn(["Facebook","Twitter"])

struct Review: Shareable {
    // Use an enum as the type
    enum Site : String {
        case Youtube
        case Vimeo
    }
    
    func shareArticleOn(_ site: Site) {
        switch site {
        case .Youtube:
            print("review posted on Youtube!")
        case .Vimeo:
            print("review posted on Vimeo!")
        }
    }
}

let review = Review()
review.shareArticleOn(.Youtube)
