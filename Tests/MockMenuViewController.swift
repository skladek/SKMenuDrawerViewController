@testable import SKMenuDrawerViewController

class MockMenuViewController: UIViewController, MenuViewControllerProtocol {
    var initialContentViewControllerCalled = false
    var viewDidAppearCalled = false
    var viewDidDisappearCalled = false
    var viewWillAppearCalled = false
    var viewWillDisappearCalled = false

    func initialContentViewController() -> UIViewController {
        initialContentViewControllerCalled = true

        return UIViewController()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearCalled = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewDidDisappearCalled = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearCalled = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearCalled = true
    }
}

class MockNonViewControllerMenuItem: MenuViewControllerProtocol {
    func initialContentViewController() -> UIViewController {
        return UIViewController()
    }
}
