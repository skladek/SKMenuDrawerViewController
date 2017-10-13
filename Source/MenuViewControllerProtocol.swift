import Foundation

/// Provides the methods that the menu view controller must adopt.
public protocol MenuViewControllerProtocol {

    /// Returns the view controller to be initially displayed in the content pane.
    func initialContentViewController() -> UIViewController
}
