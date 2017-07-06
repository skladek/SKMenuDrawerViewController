import Foundation

open class MenuDrawerViewController: UIViewController {

    static let animationDuration = 0.33

    static let menuWidthPercentage: CGFloat = 0.75

    static let springDampening: CGFloat = 0.6

    var contentViewController: UIViewController

    var menuRightConstraint: NSLayoutConstraint?

    let menuViewController: UIViewController

    public init(contentViewController: UIViewController, menuViewController: UIViewController) {
        self.contentViewController = contentViewController
        self.menuViewController = menuViewController

        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        return nil
    }

    open override func setRootContentViewController(_ viewController: UIViewController) {
        addContentViewController(viewController)
        fadeFrom(contentViewController, to: viewController)
    }

    open override func toggleMenu(animated: Bool = true) {
        let menuOffset = (menuRightConstraint?.constant == 0) ? ceil(view.frame.width * 0.75) : 0
        menuRightConstraint?.constant = menuOffset

        let duration = menuAnimationDuration(animated: animated)

        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: MenuDrawerViewController.springDampening, initialSpringVelocity: 0, options: [], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
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
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[menuView]|", options: [], metrics: nil, views: ["menuView": viewController.view]))

        let widthConstraint = NSLayoutConstraint(item: viewController.view, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: MenuDrawerViewController.menuWidthPercentage, constant: 0)
        widthConstraint.priority = UILayoutPriorityDefaultHigh
        view.addConstraint(widthConstraint)

        let leftConstraint = NSLayoutConstraint(item: viewController.view, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        view.addConstraint(leftConstraint)

        let menuConstraint = NSLayoutConstraint(item: viewController.view, attribute: .right, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        view.addConstraint(menuConstraint)
        menuRightConstraint = menuConstraint

        viewController.didMove(toParentViewController: self)
    }

    func fadeFrom(_ fromViewController: UIViewController, to toViewController: UIViewController) {
        UIView.animate(withDuration: MenuDrawerViewController.animationDuration, animations: {
            fromViewController.view.alpha = 0.0
        }) { [weak self] (_) in
            fromViewController.view.removeFromSuperview()
            self?.contentViewController.willMove(toParentViewController: nil)
            self?.contentViewController.removeFromParentViewController()
            self?.contentViewController = toViewController
        }
    }

    func menuAnimationDuration(animated: Bool) -> TimeInterval {
        return (animated) ? MenuDrawerViewController.animationDuration : 0.0
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        addContentViewController(contentViewController)
        addMenuViewController(menuViewController)
    }
}
