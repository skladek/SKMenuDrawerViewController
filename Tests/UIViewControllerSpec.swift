import Foundation
import Nimble
import Quick

@testable import SKMenuDrawerViewController

class UIViewControllerSpec: QuickSpec {
    override func spec() {
        var childViewController: UIViewController!
        var unitUnderTest: MockUIViewController!

        describe("UIViewController") {
            context("toggleMenu(animated:)") {
                beforeEach {
                    childViewController = UIViewController()
                    unitUnderTest = MockUIViewController()
                    unitUnderTest.addChildViewController(childViewController)
                }

                it("Should call toggleMenu on the parent view controller") {
                    childViewController.toggleMenu()
                    expect(unitUnderTest.toggleMenuCalled).to(beTrue())
                }
            }

            context("setRootContentViewController(_:)") {
                beforeEach {
                    childViewController = UIViewController()
                    unitUnderTest = MockUIViewController()
                    unitUnderTest.addChildViewController(childViewController)
                }

                it("Should call setRootContentViewController on the parent view controller") {
                    childViewController.setRootContentViewController(UIViewController())
                    expect(unitUnderTest.setRootViewControllerCalled).to(beTrue())
                }
            }
        }
    }
}
