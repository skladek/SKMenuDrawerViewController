@testable import SKMenuDrawerViewController

class MockMenuViewController: UIViewController, MenuViewControllerProtocol {
    var initialContentViewControllerCalled = false

    func initialContentViewController() -> UIViewController {
        initialContentViewControllerCalled = true

        return UIViewController()
    }

    func setRootContentViewController(_ viewController: UIViewController) {}

    func toggleMenu() {}
}
