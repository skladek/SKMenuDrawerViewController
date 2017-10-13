import Foundation

extension UIViewController {
    open func setRootContentViewController(_ viewController: UIViewController) {
        if let rootViewController = self as? MenuDrawerViewController {
            rootViewController.setRootContentViewControllerOnMenuViewController(viewController)
            return
        }

        parent?.setRootContentViewController(viewController)
    }

    @objc
    open func toggleMenu() {
        if let rootViewController = self as? MenuDrawerViewController {
            rootViewController.toggleMenuOnMenuViewController()
            return
        }

        parent?.toggleMenu()
    }
}
