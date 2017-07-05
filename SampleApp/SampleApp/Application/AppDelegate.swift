import SKMenuDrawerViewController
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let contentViewController = ContentViewController(color: .red)
        let menuViewController = MenuViewController()
        let rootViewController = MenuDrawerViewController(contentViewController: contentViewController, menuViewController: menuViewController)
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()

        return true
    }
}

