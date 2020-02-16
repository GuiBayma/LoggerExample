import Foundation

enum LogType {

    /// AppDelegate messages
    case appDelegate

    /// SceneDelegate messages
    case sceneDelegate

    /// UIViewController messages
    case controller

    var name: String {
        return String(describing: self)
    }
}
