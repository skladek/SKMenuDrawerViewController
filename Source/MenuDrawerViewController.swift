import Foundation

open class MenuDrawerViewController: UIViewController {

    static let animationDuration = 0.25

    static let menuWidthPercentage: CGFloat = 0.75

    let backgroundDim = UIControl()

    var contentViewController: UIViewController

    var menuLeftConstraint: NSLayoutConstraint?

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

    open override func toggleMenu() {
        let animateIntoView = (menuRightConstraint?.constant == 0)

        let menuOffset = (animateIntoView) ? ceil(view.frame.width * 0.75) : 0
        menuRightConstraint?.constant = menuOffset

        let duration = MenuDrawerViewController.animationDuration

        animateBackgroundDim(duration: duration, intoView: animateIntoView)

        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    func addContentViewController(_ viewController: UIViewController) {
        addChildViewController(viewController)
        view.insertSubview(viewController.view, at: 0)
        view.layoutIfNeeded()
        viewController.didMove(toParentViewController: self)
    }

    func addMenuViewController(_ viewController: UIViewController) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        addChildViewController(viewController)
        view.addSubview(viewController.view)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[menuView]|", options: [], metrics: nil, views: ["menuView": viewController.view]))

        let leftConstraint = NSLayoutConstraint(item: viewController.view, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: -menuWidth())
        view.addConstraint(leftConstraint)
        menuLeftConstraint = leftConstraint

        let menuConstraint = NSLayoutConstraint(item: viewController.view, attribute: .right, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        view.addConstraint(menuConstraint)
        menuRightConstraint = menuConstraint

        viewController.didMove(toParentViewController: self)
    }

    func addBackgroundDim() {
        backgroundDim.translatesAutoresizingMaskIntoConstraints = false
        backgroundDim.backgroundColor = UIColor(white: 0.0, alpha: 0.15)
        view.insertSubview(backgroundDim, belowSubview: menuViewController.view)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view": backgroundDim]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view": backgroundDim]))
        backgroundDim.alpha = 0
        backgroundDim.addTarget(self, action: #selector(toggleMenu), for: .touchUpInside)
    }

    func animateBackgroundDim(duration: TimeInterval, intoView: Bool) {
        let endingAlpha: CGFloat = (intoView) ? 1.0 : 0.0

        UIView.animate(withDuration: duration) {
            self.backgroundDim.alpha = endingAlpha
        }
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

    func menuWidth() -> CGFloat {
        return ceil(view.frame.width * MenuDrawerViewController.menuWidthPercentage)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        addContentViewController(contentViewController)
        addMenuViewController(menuViewController)
        addBackgroundDim()
    }

    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let menuIsClosed = (menuRightConstraint?.constant == 0)
        let width = menuWidth()
        let leftConstant = (menuIsClosed) ? -width : 0
        let rightConstant = (menuIsClosed) ? 0 : width
        menuLeftConstraint?.constant = leftConstant
        menuRightConstraint?.constant = rightConstant
    }
}
