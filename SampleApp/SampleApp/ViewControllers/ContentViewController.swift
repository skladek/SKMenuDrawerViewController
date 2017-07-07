import Foundation
import SKTableViewDataSource
import UIKit

class ContentViewController: UIViewController {
    var dataSource: TableViewDataSource<String>?

    let jobs = ["Content Row 1", "Content Row 2", "Content Row 3", "Content Row 4", "Content Row 5"]

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = TableViewDataSource(objects: jobs, cell: UITableViewCell.self, cellPresenter: { (cell, object) in
            cell.textLabel?.text = object
        })

        tableView.dataSource = dataSource
    }
}
