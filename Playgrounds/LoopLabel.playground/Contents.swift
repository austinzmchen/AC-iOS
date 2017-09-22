
import Foundation

let sections = [
    [1,2],
    [1,3,4],
    [1,5],
]

// without loop label before
for section in sections {
    var foundTheMagicalRow = false
    for row in section {
        if row == 4 {
            foundTheMagicalRow = true
            break // break only break innerloop
        }
        print("no looplabel before: row \(row)")
    }
    print("no looplabel before: section \(section)")
}

print("\n")

// without loop label after
for section in sections {
    var foundTheMagicalRow = false
    for row in section {
        if row == 4 {
            foundTheMagicalRow = true
            break
        }
        print("no looplabel after: row \(row)")
    }
    if foundTheMagicalRow {
        //We found the magical row!
        //No need to continue looping through our sections now.
        break
    }
    print("no looplabel after: section \(section)")
}

print("\n")

// with loop label
sectionLoop: for section in sections {
    rowLoop: for row in section {
        if row == 4 {
            break sectionLoop // also works with 'continue'
        }
        print("looplabel: row \(row)")
    }
    print("looplabel: section \(section)")
}
