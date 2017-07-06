import UIKit

class MockUIViewController: UIViewController {
    var setRootViewControllerCalled = false
    var toggleMenuCalled = false

    override func setRootContentViewController(_ viewController: UIViewController) {
        setRootViewControllerCalled = true
    }

    override func toggleMenu(animated: Bool) {
        toggleMenuCalled = true
    }
}
