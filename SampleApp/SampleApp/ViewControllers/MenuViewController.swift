import Foundation
import SKMenuDrawerViewController
import SKTableViewDataSource
import UIKit

class MenuViewController: UIViewController, MenuViewControllerProtocol {

    var dataSource: TableViewDataSource<String>?
    @IBOutlet weak var tableView: UITableView!

    func initialContentViewController() -> UIViewController {
        let indexPath = IndexPath(row: 0, section: 0)

        return viewControllerForIndexPath(indexPath)
    }

    func viewControllerForIndexPath(_ indexPath: IndexPath) -> UIViewController {
        let viewController = ContentViewController()
        let navigationController = NavigationController(rootViewController: viewController)

        return navigationController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let options = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"]

        dataSource = TableViewDataSource(objects: options, cell: UITableViewCell.self) { (cell, object) in
            cell.textLabel?.text = object
        }

        tableView.dataSource = dataSource
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navigationController = viewControllerForIndexPath(indexPath)
        parent?.setRootContentViewController(navigationController)
        parent?.toggleMenu()
    }
}
