import SKMenuDrawerViewController
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let contentViewController = ContentViewController()
        let contentNavigationController = NavigationController(rootViewController: contentViewController)
        let menuViewController = MenuViewController()
        let menuNavigationController = UINavigationController(rootViewController: menuViewController)
        let rootViewController = MenuDrawerViewController(contentViewController: contentNavigationController, menuViewController: menuNavigationController)
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()

        return true
    }
}

