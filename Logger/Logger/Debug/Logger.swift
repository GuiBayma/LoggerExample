import Foundation

final class Logger {

    static private var sharedInstance: Logger?

    static var shared: Logger {
        guard let sharedInstance = sharedInstance else {
            fatalError("Logger: call setup() first")
        }
        return sharedInstance
    }

    static func setup(queue: DispatchQueue = DispatchQueue.init(label: "logger"),
                      logLevel: LogLevel = .verbose) {
        if sharedInstance == nil {
            sharedInstance = Logger(queue: queue, logLevel: logLevel)
        }
    }

    private init(queue: DispatchQueue, logLevel: LogLevel) {
        self.queue = queue
        self.logLevel = logLevel
    }

    private let queue: DispatchQueue
    private let logLevel: LogLevel

    func log(_ logType: LogType,
             _ logMessage: String? = nil,
             file: String = #file,
             functionName: String = #function,
             lineNumber: Int = #line) {

        guard Env.configuration == .debug, shouldLog(type: logType) else { return }

        // Get only the file name without the full path
        var filename = (file as NSString).lastPathComponent
        filename = filename.components(separatedBy: ".")[0]

        // Generate current date string
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS"
        let dateString = formatter.string(from: currentDate)

        var message =
        """
        ┌────────────────────────────────────────────────────────────────────────
        │ \(dateString) \n│ \(filename).\(functionName) (\(lineNumber)) [\(logType.name)]
        └────────────────────────────────────────────────────────────────────────\n
        """

        if let logMessage = logMessage {
            message.append(" \(logMessage)\n")
        }

        queue.async {
            print(message)
        }
    }

    private func shouldLog(type: LogType) -> Bool {
        if case let LogLevel.filtered(logType) = logLevel, logType != type {
            return false
        }
        return true
    }
}
