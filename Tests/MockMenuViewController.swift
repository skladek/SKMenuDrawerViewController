@testable import SKMenuDrawerViewController

class MockMenuViewController: UIViewController, MenuViewControllerProtocol {
    var initialContentViewControllerCalled = false

    func initialContentViewController() -> UIViewController {
        initialContentViewControllerCalled = true

        return UIViewController()
    }
}

class MockNonViewControllerMenuItem: MenuViewControllerProtocol {
    func initialContentViewController() -> UIViewController {
        return UIViewController()
    }
}
