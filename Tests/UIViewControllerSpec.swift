import Foundation
import Nimble
import Quick

@testable import SKMenuDrawerViewController

class UIViewControllerSpec: QuickSpec {
    override func spec() {
        var menuDrawerViewController: MockMenuDrawerViewController!
        var unitUnderTest: MockMenuViewController!

        describe("UIViewController") {
            beforeEach {
                unitUnderTest = MockMenuViewController()
            }

            context("setRootContentViewController(_:)") {
                it("Should call setRootContentViewControllerOnMenuViewController on the menu drawer view controller") {
                    menuDrawerViewController = MockMenuDrawerViewController(menuViewController: unitUnderTest)
                    menuDrawerViewController.viewDidLoad()
                    unitUnderTest.setRootContentViewController(UIViewController())

                    expect(menuDrawerViewController.setRootContentViewControllerCalled).to(beTrue())
                }
            }

            context("toggleMenu()") {
                it("Should call toggleMenuOnMenuViewController on the menu drawer view controller") {
                    menuDrawerViewController = MockMenuDrawerViewController(menuViewController: unitUnderTest)
                    menuDrawerViewController.viewDidLoad()
                    unitUnderTest.toggleMenu()

                    expect(menuDrawerViewController.toggleMenuCalled).to(beTrue())
                }
            }
        }
    }
}
