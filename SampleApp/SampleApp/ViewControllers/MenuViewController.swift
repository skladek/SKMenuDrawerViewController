import Foundation
import SKMenuDrawerViewController
import SKTableViewDataSource
import UIKit

class MenuViewController: UIViewController {

    var dataSource: TableViewDataSource<ContentViewController.Color>?
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let colors: [ContentViewController.Color] = [.red, .green, .blue]

        dataSource = TableViewDataSource(objects: colors, cell: UITableViewCell.self) { (cell, color) in
            var title: String? = nil

            switch color {
            case .blue:
                title = "Blue"
            case .green:
                title = "Green"
            case .red:
                title = "Red"
            }

            cell.textLabel?.text = title
        }

        tableView.dataSource = dataSource
        view.backgroundColor = .yellow
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let color = ContentViewController.Color(rawValue: indexPath.row),
            let parentViewController = parent as? MenuDrawerViewController else {
                return
        }

        let viewController = ContentViewController(color: color)
        parentViewController.rootContentViewController(viewController)
    }
}
