import Foundation
import Nimble
import Quick

@testable import SKMenuDrawerViewController

class MenuDrawerViewControllerSpec: QuickSpec {
    override func spec() {
        var unitUnderTest: MenuDrawerViewController!

        describe("MenuDrawerViewController") {
            context("init(contentViewController:menuViewController:)") {
                var contentViewController: UIViewController!
                var menuViewController: UIViewController!

                beforeEach {
                    contentViewController = UIViewController()
                    menuViewController = UIViewController()
                    unitUnderTest = MenuDrawerViewController(contentViewController: contentViewController, menuViewController: menuViewController)
                }

                it("Should set the content view controller") {
                    expect(unitUnderTest.contentViewController).to(be(contentViewController))
                }

                it("Should set the menu view controller") {
                    expect(unitUnderTest.menuViewController).to(be(menuViewController))
                }
            }

            context("init?(coder:)") {
                beforeEach {
                    let coder = NSCoder()
                    unitUnderTest = MenuDrawerViewController(coder: coder)
                }

                it("Should return nil") {
                    expect(unitUnderTest).to(beNil())
                }
            }

            context("setRootContentViewController(_:)") {
                beforeEach {
                    unitUnderTest = MockMenuDrawerViewController(contentViewController: UIViewController(), menuViewController: UIViewController())
                    unitUnderTest.setRootContentViewController(UIViewController())
                }

                it("Should call addContentViewController") {
                    expect((unitUnderTest as! MockMenuDrawerViewController).addContentViewControllerCalled).to(beTrue())
                }

                it("Should call fadeFromTo") {
                    expect((unitUnderTest as! MockMenuDrawerViewController).fadeFromToCalled).to(beTrue())
                }
            }

            context("toggleMenu()") {
                var menuViewController: UIViewController!

                beforeEach {
                    menuViewController = UIViewController()
                    unitUnderTest = MenuDrawerViewController(contentViewController: UIViewController(), menuViewController: menuViewController)
                    expect(unitUnderTest.view).toNot(beNil())
                    unitUnderTest.viewDidLoad()
                    unitUnderTest.view.layoutIfNeeded()
                }

                it("Should set the constraint constant to 0 on the second menu toggle") {
                    unitUnderTest.toggleMenu(animated: false)
                    unitUnderTest.toggleMenu(animated: false)
                    expect(unitUnderTest.menuRightConstraint?.constant).to(equal(0))
                }
            }

            context("addContentViewController(_:)") {
                var viewController: UIViewController!

                beforeEach {
                    unitUnderTest = MenuDrawerViewController(contentViewController: UIViewController(), menuViewController: UIViewController())
                    viewController = UIViewController()
                    unitUnderTest.addContentViewController(viewController)
                }

                it("Should add the view controller as a child view controller") {
                    expect(unitUnderTest.childViewControllers).to(contain(viewController))
                }

                it("Should add the view as a subview") {
                    expect(unitUnderTest.view.subviews).to(contain(viewController.view))
                }
            }

            context("addMenuViewController(_:)") {
                var viewController: UIViewController!

                beforeEach {
                    unitUnderTest = MenuDrawerViewController(contentViewController: UIViewController(), menuViewController: UIViewController())
                    viewController = UIViewController()
                    unitUnderTest.addMenuViewController(viewController)
                }

                it("Should add the view controller as a child view controller") {
                    expect(unitUnderTest.childViewControllers).to(contain(viewController))
                }

                it("Should add the view as a subview") {
                    expect(unitUnderTest.view.subviews).to(contain(viewController.view))
                }
            }

            context("fadeFrom(_:to:)") {
                var fromViewController: UIViewController!
                var toViewController: UIViewController!

                beforeEach {
                    fromViewController = UIViewController()
                    toViewController = UIViewController()
                    unitUnderTest = MenuDrawerViewController(contentViewController: fromViewController, menuViewController: UIViewController())
                    unitUnderTest.fadeFrom(fromViewController, to: toViewController)
                }

                it("Should eventually set the from view controller alpha to zero") {
                    expect(fromViewController.view.alpha).toEventually(equal(0.0))
                }

                it("Should eventually remove the from view controller as a child view controller") {
                    expect(unitUnderTest.childViewControllers).toEventuallyNot(contain(fromViewController))
                }

                it("Should eventually remove the from view as a subview") {
                    expect(unitUnderTest.view.subviews).toEventuallyNot(contain(fromViewController.view))
                }

                it("Should eventually set the to view controller as the content view controller") {
                    expect(unitUnderTest.contentViewController).toEventually(equal(toViewController))
                }
            }

            context("menuAnimationDuration(animated:)") {
                beforeEach {
                    unitUnderTest = MenuDrawerViewController(contentViewController: UIViewController(), menuViewController: UIViewController())
                }

                it("Should return 0.0 if animated is false") {
                    expect(unitUnderTest.menuAnimationDuration(animated: false)).to(equal(0.0))
                }

                it("Should return the menu animation duration constant if animated is true") {
                    expect(unitUnderTest.menuAnimationDuration(animated: true)).to(equal(MenuDrawerViewController.animationDuration))
                }
            }
        }
    }
}
