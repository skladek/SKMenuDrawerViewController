import Foundation

/// Provides the container view controller to controller the menu and content view controllers.
@objc
open class MenuDrawerViewController: UIViewController {

    // MARK: Public Variables

    /// The view controller used for the side menu.
    @objc
    public let menuViewController: UIViewController

    // MARK: Static Variables

    let animationDuration = 0.25

    let menuWidthPercentage: CGFloat = 0.75

    // MARK: Internal Variables

    let backgroundDim = UIControl()

    var contentViewController: UIViewController

    var menuIsOpen = false

    var menuLeftConstraint: NSLayoutConstraint?

    var menuRightConstraint: NSLayoutConstraint?

    // MARK: Initializers

    /// Initializes a view controller with a MenuViewControllerProtocol. If the menuViewController does not inherit from
    /// UIViewController, the initializer will return nil.
    ///
    /// - Parameters:
    ///   - menuViewController: The view controller to display on the menu side.
    @objc
    public init?(menuViewController: MenuViewControllerProtocol) {
        self.contentViewController = menuViewController.initialContentViewController()

        guard let menuViewController = menuViewController as? UIViewController else {
            return nil
        }
        self.menuViewController = menuViewController

        super.init(nibName: nil, bundle: nil)
    }

    /// Returns nil. This is not supported.
    @objc
    required public init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: Internal Methods

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
        backgroundDim.addTarget(self, action: #selector(toggleMenuOnMenuViewController), for: .touchUpInside)
    }

    func animateBackgroundDim(duration: TimeInterval) {
        let endingAlpha: CGFloat = (menuIsOpen) ? 1.0 : 0.0

        UIView.animate(withDuration: duration) {
            self.backgroundDim.alpha = endingAlpha
        }
    }

    func fadeFrom(_ fromViewController: UIViewController, to toViewController: UIViewController) {
        UIView.animate(withDuration: animationDuration, animations: {
            fromViewController.view.alpha = 0.0
        }, completion: { [weak self] (_) in
            fromViewController.view.removeFromSuperview()
            self?.contentViewController.willMove(toParentViewController: nil)
            self?.contentViewController.removeFromParentViewController()
            self?.contentViewController = toViewController
        })
    }

    func menuWidth() -> CGFloat {
        return ceil(view.frame.width * menuWidthPercentage)
    }

    func setRootContentViewControllerOnMenuViewController(_ viewController: UIViewController) {
        addContentViewController(viewController)
        fadeFrom(contentViewController, to: viewController)
    }

    @objc
    func toggleMenuOnMenuViewController() {
        menuIsOpen = !menuIsOpen
        let duration = animationDuration
        animateBackgroundDim(duration: duration)
        view.setNeedsLayout()

        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    // MARK: UIViewController Methods

    /// Adds the content and menu view controllers to the container view.
    @objc
    open override func viewDidLoad() {
        super.viewDidLoad()

        addContentViewController(contentViewController)
        addMenuViewController(menuViewController)
        addBackgroundDim()
    }

    /// Lays out the menu drawer view.
    @objc
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let width = menuWidth()
        let leftConstant = (menuIsOpen) ? 0 : -width
        let rightConstant = (menuIsOpen) ? width : 0
        menuLeftConstraint?.constant = leftConstant
        menuRightConstraint?.constant = rightConstant
    }
}
