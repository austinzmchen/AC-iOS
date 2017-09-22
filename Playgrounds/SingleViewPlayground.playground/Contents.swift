//: A UIKit based Playground to present user interface
  
import UIKit
import PlaygroundSupport

class myViewController : UIViewController {

    override func loadView() {
        let view = UIView()

        let label = UILabel()
        label.text = "Hello World!"
        label.textColor = .white
        label.backgroundColor = UIColor.red
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        
        view.backgroundColor = UIColor.green
        view.addSubview(label)
        self.view = view
    }
   
}

PlaygroundPage.current.liveView = myViewController()
