import Foundation

open class MenuDrawerViewController: UIViewController {

    var contentViewController: UIViewController

    let menuViewController: UIViewController

    public init(contentViewController: UIViewController, menuViewController: UIViewController) {
        self.contentViewController = contentViewController
        self.menuViewController = menuViewController

        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue

        if let menuView = menuViewController.view {
            menuView.translatesAutoresizingMaskIntoConstraints = false
            addChildViewController(menuViewController)
            view.addSubview(menuView)
            view.addConstraint(NSLayoutConstraint(item: menuView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0))
            view.addConstraint(NSLayoutConstraint(item: menuView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0))
            view.addConstraint(NSLayoutConstraint(item: menuView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0.0))
            view.addConstraint(NSLayoutConstraint(item: menuView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.75, constant: 0.0))

            menuViewController.didMove(toParentViewController: self)
        }
    }
}
