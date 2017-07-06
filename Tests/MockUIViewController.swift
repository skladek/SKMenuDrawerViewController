import UIKit

class MockUIViewController: UIViewController {
    var toggleMenuCalled = false

    override func toggleMenu(animated: Bool) {
        toggleMenuCalled = true
    }
}
