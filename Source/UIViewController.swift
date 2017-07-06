import Foundation

extension UIViewController {
    open func setRootContentViewController(_ viewController: UIViewController) {
        parent?.setRootContentViewController(viewController)
    }

    open func toggleMenu(animated: Bool = true) {
        parent?.toggleMenu(animated: animated)
    }
}
