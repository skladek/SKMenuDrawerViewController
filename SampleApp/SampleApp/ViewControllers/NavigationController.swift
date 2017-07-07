import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }
}

extension NavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if navigationController.viewControllers.count == 1 {
            let barItem = UIBarButtonItem(title: "Menu", style: .plain, target: parent, action: #selector(toggleMenu))
            viewController.navigationItem.leftBarButtonItem = barItem
        }
    }
}
