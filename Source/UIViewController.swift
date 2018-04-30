import Foundation

@objc
public extension UIViewController {

    /// Sets the root content view controller on the menu view controller. This can be used to change the content
    /// view controller programatically.
    ///
    /// - Parameter viewController: The view controller to be changed to.
    @objc
    public func setRootContentViewController(_ viewController: UIViewController) {
        if let rootViewController = self as? MenuDrawerViewController {
            rootViewController.setRootContentViewControllerOnMenuViewController(viewController)
            return
        }

        parent?.setRootContentViewController(viewController)
    }

    /// Calls the menu drawer view controller to toggle the menu in/out.
    @objc
    public func toggleMenu() {
        if let rootViewController = self as? MenuDrawerViewController {
            rootViewController.toggleMenuOnMenuViewController()
            return
        }

        parent?.toggleMenu()
    }
}
