import Foundation

enum LogType {

    /// AppDelegate messages
    case appDelegate

    /// UIViewController messages
    case controller

    var name: String {
        return String(describing: self)
    }
}
