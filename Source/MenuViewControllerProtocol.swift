import Foundation

public protocol MenuViewControllerProtocol {
    func initialContentViewController() -> UIViewController
    func setRootContentViewController(_ viewController: UIViewController)
    func toggleMenu()
}
