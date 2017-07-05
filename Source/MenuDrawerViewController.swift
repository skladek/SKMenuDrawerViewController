import Foundation

open class MenuDrawerViewController: UIViewController {

    var contentViewController: UIViewController

    let menuViewController: UIViewController

    public init(contentViewController: UIViewController, menuViewController: UITableViewController) {
        self.contentViewController = contentViewController
        self.menuViewController = menuViewController

        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
