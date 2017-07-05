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

    public func rootContentViewController(_ viewController: UIViewController) {
        guard let newContentView = viewController.view,
            let oldContentView = contentViewController.view else {
                return
        }

        addChildViewController(viewController)
        viewController.didMove(toParentViewController: self)
        newContentView.alpha = 0.0
        view.insertSubview(newContentView, aboveSubview: oldContentView)

        UIView.animate(withDuration: 0.25, animations: {
            newContentView.alpha = 1.0
        }) { [weak self] (_) in
            oldContentView.removeFromSuperview()
            self?.contentViewController.willMove(toParentViewController: nil)
            self?.contentViewController.removeFromParentViewController()
            self?.contentViewController = viewController
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue

        if let contentView = contentViewController.view {
            addChildViewController(contentViewController)
            view.addSubview(contentView)

            contentViewController.didMove(toParentViewController: self)
        }

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
