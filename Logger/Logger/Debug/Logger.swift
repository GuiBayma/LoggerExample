import Foundation

final class Logger {

    static private var sharedInstance: Logger?

    static var shared: Logger {
        guard let sharedInstance = sharedInstance else {
            fatalError("Logger: call setup() first")
        }
        return sharedInstance
    }

    static func setup(queue: DispatchQueue = DispatchQueue(label: "Logger"),
                      writer: ConsoleWriterProtocol = ConsoleWriter(),
                      logLevel: LogLevel = .verbose) {
        if sharedInstance == nil {
            sharedInstance = Logger(queue: queue, writer: writer, logLevel: logLevel)
        }
    }

    static func resetInstance() {
        sharedInstance = nil
    }

    private init(queue: DispatchQueue, writer: ConsoleWriterProtocol, logLevel: LogLevel) {
        self.queue = queue
        self.writer = writer
        self.logLevel = logLevel
    }

    private let queue: DispatchQueue
    private let writer: ConsoleWriterProtocol
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
            message.append(" \(logMessage)")
        }

        queue.async {
            self.writer.print(message, separator: " ", terminator: "\n\n")
        }
    }

    private func shouldLog(type: LogType) -> Bool {
        if case let LogLevel.filtered(logType) = logLevel, logType != type {
            return false
        }
        return true
    }
}

protocol ConsoleWriterProtocol {
    func print(_ items: Any..., separator: String, terminator: String)
}

final class ConsoleWriter: ConsoleWriterProtocol {

    func print(_ items: Any..., separator: String, terminator: String) {
        let output = items.map { "\($0)" }.joined(separator: separator)
        Swift.print(output, terminator: terminator)
    }
}
