import Foundation
import Nimble
import Quick

@testable import SKMenuDrawerViewController

class UIViewControllerSpec: QuickSpec {
    override func spec() {
        var unitUnderTest: UIViewController!

        describe("MenuDrawerViewController") {
            context("toggleMenu(animated:)") {
                beforeEach {
                    unitUnderTest = UIViewController()
                }

                it("Should call toggleMenu on the parent view controller") {
                    let parentViewController = MockUIViewController()
                    parentViewController.addChildViewController(unitUnderTest)
                    unitUnderTest.toggleMenu()

                    expect(parentViewController.toggleMenuCalled).to(beTrue())
                }
            }
        }
    }
}
