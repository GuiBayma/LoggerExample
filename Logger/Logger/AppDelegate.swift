import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let controller = ViewController()
        window = UIWindow()
        window?.rootViewController = controller
        window?.makeKeyAndVisible()

        Logger.log(.appDelegate, "launchOptions: \(String(describing: launchOptions))")

        return true
    }
}
