import Foundation

extension UIViewController {
    open func toggleMenu(animated: Bool = true) {
        parent?.toggleMenu()
    }
}
