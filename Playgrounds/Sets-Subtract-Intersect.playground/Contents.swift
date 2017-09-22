//: Playground - noun: a place where people can play

import UIKit

class HAPJsonTripPoint: NSObject {
    var itemID: String = ""

    init(itemID: String) {
        self.itemID = itemID
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let obj = object as? HAPJsonTripPoint {
            return self.itemID == obj.itemID
        } else {
            return false
        }
    }
}

struct HAPMapViewCabItem {
    let point: HAPJsonTripPoint
}


extension HAPJsonTripPoint {
    override var hashValue: Int {
        get {
            return self.itemID.hashValue
        }
    }
}

func ==(lhs: HAPJsonTripPoint, rhs: HAPJsonTripPoint) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

let dict = [
    "driver_1": HAPMapViewCabItem(point: HAPJsonTripPoint(itemID: "driver_1")),
    "driver_2": HAPMapViewCabItem(point: HAPJsonTripPoint(itemID: "driver_2")),
    "driver_3": HAPMapViewCabItem(point: HAPJsonTripPoint(itemID: "driver_3")),
    "driver_4": HAPMapViewCabItem(point: HAPJsonTripPoint(itemID: "driver_4"))
]

let points = [
    HAPJsonTripPoint(itemID: "driver_1"),
    HAPJsonTripPoint(itemID: "driver_2"),
    HAPJsonTripPoint(itemID: "driver_5")
]

let localSet: Set<HAPJsonTripPoint> = Set( dict.values.map({$0.point}) )
let remoteSet: Set<HAPJsonTripPoint> = Set(points)

let intersects: Set<HAPJsonTripPoint> = localSet.intersection(remoteSet)

let toAddSet: Set<HAPJsonTripPoint> = remoteSet.subtracting(localSet)
let toRemove: Set<HAPJsonTripPoint> = localSet.subtracting(remoteSet)

