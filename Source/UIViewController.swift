import Foundation

public extension UIViewController {
    public func toggleMenu(animated: Bool = true) {
        parent?.toggleMenu()
    }
}
