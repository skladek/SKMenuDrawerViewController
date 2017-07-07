import Foundation
import SKTableViewDataSource
import UIKit

class MenuViewController: UIViewController {

    var dataSource: TableViewDataSource<String>?
    @IBOutlet weak var tableView: UITableView!

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
        let viewController = ContentViewController()
        let navigationController = NavigationController(rootViewController: viewController)
        parent?.setRootContentViewController(navigationController)

        parent?.toggleMenu()
    }
}
