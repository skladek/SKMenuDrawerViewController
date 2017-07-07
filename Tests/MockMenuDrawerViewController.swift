@testable import SKMenuDrawerViewController

class MockMenuDrawerViewController: MenuDrawerViewController<MockMenuViewController> {
    var addContentViewControllerCalled = false
    var fadeFromToCalled = false

    override func addContentViewController(_ viewController: UIViewController) {
        addContentViewControllerCalled = true
    }

    override func fadeFrom(_ fromViewController: UIViewController, to toViewController: UIViewController) {
        fadeFromToCalled = true
    }
}
