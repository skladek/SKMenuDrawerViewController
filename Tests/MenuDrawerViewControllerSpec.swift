import Foundation
import Nimble
import Quick

@testable import SKMenuDrawerViewController

class MenuDrawerViewControllerSpec: QuickSpec {
    override func spec() {
        var unitUnderTest: MenuDrawerViewController!

        describe("MenuDrawerViewController") {
            context("init(contentViewController:menuViewController:)") {
                var menuViewController: MockMenuViewController!

                beforeEach {
                    menuViewController = MockMenuViewController()
                    unitUnderTest = MenuDrawerViewController(menuViewController: menuViewController)
                }

                it("Should set the menu view controller") {
                    expect(unitUnderTest.menuViewController).to(be(menuViewController))
                }

                it("Should call initialContentViewController on the menu view controller") {
                    expect(menuViewController.initialContentViewControllerCalled).to(beTrue())
                }

                it("Should return nil if the menu view controller does not inherit from UIViewController") {
                    let menuViewController = MockNonViewControllerMenuItem()
                    unitUnderTest = MenuDrawerViewController(menuViewController: menuViewController)
                    expect(unitUnderTest).to(beNil())
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

            context("setRootContentViewControllerOnMenuViewController(_:)") {
                beforeEach {
                    unitUnderTest = MockMenuDrawerViewControllerWithoutUIViewControllerOverrides(menuViewController: MockMenuViewController())
                    unitUnderTest.setRootContentViewControllerOnMenuViewController(UIViewController())
                }

                it("Should call addContentViewController") {
                    expect((unitUnderTest as! MockMenuDrawerViewControllerWithoutUIViewControllerOverrides).addContentViewControllerCalled).to(beTrue())
                }

                it("Should call fadeFromTo") {
                    expect((unitUnderTest as! MockMenuDrawerViewControllerWithoutUIViewControllerOverrides).fadeFromToCalled).to(beTrue())
                }
            }

            context("toggleMenu()") {
                var menuViewController: MockMenuViewController!

                beforeEach {
                    menuViewController = MockMenuViewController()
                    unitUnderTest = MenuDrawerViewController(menuViewController: menuViewController)
                    expect(unitUnderTest.view).toNot(beNil())
                    unitUnderTest.viewDidLoad()
                    unitUnderTest.view.layoutIfNeeded()
                }

                it("Should set the constraint constant to 0 on the second menu toggle") {
                    unitUnderTest.toggleMenu()
                    unitUnderTest.toggleMenu()
                    expect(unitUnderTest.menuRightConstraint?.constant).to(equal(0))
                }
            }

            context("addContentViewController(_:)") {
                var viewController: UIViewController!

                beforeEach {
                    unitUnderTest = MenuDrawerViewController(menuViewController: MockMenuViewController())
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
                    unitUnderTest = MenuDrawerViewController(menuViewController: MockMenuViewController())
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
                    unitUnderTest = MenuDrawerViewController(menuViewController: MockMenuViewController())
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
        }
    }
}
