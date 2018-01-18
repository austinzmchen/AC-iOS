//: Swift override protocol methods example

import UIKit
import MessageUI

// not working, compiles only because presentationControll() is optional
protocol P1 : UIAdaptivePresentationControllerDelegate {
}

extension P1 where Self : UIViewController {
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        return UIViewController()
    }
}

class C1 : UIViewController, P1 {}



// not compiling, because can not override objc based protocol (NSObjectProtocol)
public protocol P2: MFMessageComposeViewControllerDelegate {
}

extension P2 where Self: UIViewController {
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
    }
}

class C2: UIViewController, P2 {}


// works, because CustomStringConvertible is not objc based protocol
public protocol P3: CustomStringConvertible {
}

extension P3 where Self: UIViewController {
    public var description: String {
        return "uiviewcontroller"
    }
}

class C3: UIViewController, P3 {}

