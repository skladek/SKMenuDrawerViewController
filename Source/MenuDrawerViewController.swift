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
        return nil
    }

    public func setRootContentViewController(_ viewController: UIViewController) {
        addContentViewController(viewController)
        fadeFrom(contentViewController, to: viewController)
    }

    func addContentViewController(_ viewController: UIViewController) {
        addChildViewController(viewController)
        view.insertSubview(viewController.view, at: 0)
        viewController.didMove(toParentViewController: self)
    }

    func addMenuViewController(_ viewController: UIViewController) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        addChildViewController(viewController)
        view.addSubview(viewController.view)
        view.addConstraint(NSLayoutConstraint(item: viewController.view, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: viewController.view, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: viewController.view, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: viewController.view, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.75, constant: 0.0))

        viewController.didMove(toParentViewController: self)
    }

    func fadeFrom(_ fromViewController: UIViewController, to toViewController: UIViewController) {
        UIView.animate(withDuration: 0.25, animations: {
            fromViewController.view.alpha = 0.0
        }) { [weak self] (_) in
            fromViewController.view.removeFromSuperview()
            self?.contentViewController.willMove(toParentViewController: nil)
            self?.contentViewController.removeFromParentViewController()
            self?.contentViewController = toViewController
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        addContentViewController(contentViewController)
        addMenuViewController(menuViewController)
    }
}
