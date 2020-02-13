import Foundation

enum LogLevel {

    /// Logs everything
    case verbose

    /// Log only  messages of the chosen type
    case filtered(LogType)
}
