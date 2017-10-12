import Foundation

extension UIViewController {
    open func setRootContentViewController(_ viewController: UIViewController) {
        parent?.setRootContentViewController(viewController)
    }

    open func toggleMenu() {
        parent?.toggleMenu()
    }
}
