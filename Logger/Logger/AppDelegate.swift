import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: - Initializing the App

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Logger.setup()
        Logger.shared.log(.appDelegate)
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let controller = ViewController()
        window = UIWindow()
        window?.rootViewController = controller
        window?.makeKeyAndVisible()

        Logger.shared.log(.appDelegate, "launchOptions: \(String(describing: launchOptions))")

        return true
    }

    // MARK: - App Life-Cycle Events

    func applicationDidBecomeActive(_ application: UIApplication) {
        Logger.shared.log(.appDelegate)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        Logger.shared.log(.appDelegate)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        Logger.shared.log(.appDelegate)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        Logger.shared.log(.appDelegate)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        Logger.shared.log(.appDelegate)
    }

    // MARK: - Environment Changes

    /// Tells when there is a significant change in the time.
    func applicationSignificantTimeChange(_ application: UIApplication) {
        Logger.shared.log(.appDelegate)
    }

    // MARK: - App State Restoration

    func application(_ application: UIApplication, shouldSaveSecureApplicationState coder: NSCoder) -> Bool {
        Logger.shared.log(.appDelegate)
        return true
    }

    func application(_ application: UIApplication, shouldRestoreSecureApplicationState coder: NSCoder) -> Bool {
        Logger.shared.log(.appDelegate)
        return true
    }
}
