//: Playground - noun: a place where people can play

import UIKit

class TableViewController: UIViewController {
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    }
}

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}


class SubTableViewController: TableViewController {
}

extension SubTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
}


//

protocol SampleProtocol {
    func method1()
}

class VC1: SampleProtocol {
    func method1() {
        print("method1")
    }
}

class SubVC1: VC1 {
    override func method1() {
        print("override method1")
    }
}
