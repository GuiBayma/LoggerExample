import UIKit

let isRunningTests = NSClassFromString("XCTestCase") != nil
let appDelegateClass = isRunningTests ? nil : NSStringFromClass(AppDelegate.self)
_ = UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, appDelegateClass)
