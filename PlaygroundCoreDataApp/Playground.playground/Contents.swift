//: Playground - noun: a place where people can play

import UIKit
import CoreData

var str = "Hello, playground"

class ACUrlCache: NSObject {
    static let shared = ACUrlCache()
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PlaygroundCoreDataApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

let cache = ACUrlCache.shared
var results: [NSManagedObject]? = nil

let context = ACUrlCache.shared.persistentContainer.newBackgroundContext()

// write
let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context)
employee.setValue("austin", forKey: "name")
employee.setValue(32, forKey: "age")

if context.hasChanges {
    print("abc")
    try context.save()
}

// read
let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
fetchRequest.predicate = NSPredicate(format:"name == %@", "austin")

do {
    results = try context.fetch(fetchRequest) as? [NSManagedObject]
    
} catch let error as NSError {
    print(error.localizedDescription)
}

if let rs = results {
    rs.map({
        print($0)
    })
}

