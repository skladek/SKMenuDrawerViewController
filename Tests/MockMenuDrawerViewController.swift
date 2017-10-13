@testable import SKMenuDrawerViewController

class MockMenuDrawerViewController: MenuDrawerViewController {
    var setRootContentViewControllerCalled = false
    var toggleMenuCalled = false

    override func setRootContentViewControllerOnMenuViewController(_ viewController: UIViewController) {
        setRootContentViewControllerCalled = true
    }

    override func toggleMenuOnMenuViewController() {
        toggleMenuCalled = true
    }
}

class MockMenuDrawerViewControllerWithoutUIViewControllerOverrides: MenuDrawerViewController {
    var addContentViewControllerCalled = false
    var fadeFromToCalled = false

    override func addContentViewController(_ viewController: UIViewController) {
        addContentViewControllerCalled = true
    }

    override func fadeFrom(_ fromViewController: UIViewController, to toViewController: UIViewController) {
        fadeFromToCalled = true
    }
}
