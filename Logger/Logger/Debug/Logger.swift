import Foundation

final class Logger {

    static private var sharedInstance: Logger?

    /// Logger shared instance.
    static var shared: Logger {
        guard let sharedInstance = sharedInstance else {
            fatalError("Logger: call setup() first")
        }
        return sharedInstance
    }

    /// Setup method for Logger class. Should be called before trying to retrieve shared instance.
    /// - Parameters:
    ///   - queue: `DispatchQueue` - queue the logger will write on. Default value is `DispatchQueue(label: "Logger")`.
    ///   - modules: `[WriterProtocol]` - array the logger will call `write` method. Default value is `[ConsoleWriter()]`.
    ///   - logLevel: `LogLevel` - can be `verbose` or `filtered`. Default value is `.verbose`.
    static func setup(queue: DispatchQueue = DispatchQueue(label: "Logger"),
                      modules: [WriterProtocol] = [ConsoleWriter()],
                      logLevel: LogLevel = .verbose) {
        if sharedInstance == nil {
            sharedInstance = Logger(queue: queue, modules: modules, logLevel: logLevel)
        }
    }

    /// Set the shared instance to `nil`. Used mainly for testing purposes.
    static func resetInstance() {
        sharedInstance = nil
    }

    private init(queue: DispatchQueue, modules: [WriterProtocol], logLevel: LogLevel) {
        self.queue = queue
        self.modules = modules
        self.logLevel = logLevel
    }

    private let queue: DispatchQueue
    private let modules: [WriterProtocol]
    private let logLevel: LogLevel

    /// Called to write a log.
    /// - Parameters:
    ///   - logType: `LogType` - classification of the log message.
    ///   - logMessage: `String?` - optional log message. Default value is `nil`.
    ///   - file: `String` - name of the file the log was called. Default value is `#file`.
    ///   - functionName: `String` - name of the function the log was called. Default value is `#function`.
    ///   - lineNumber: `Int` - number of the line the log was called. Default value is `#line`.
    func log(_ logType: LogType,
             _ logMessage: String? = nil,
             file: String = #file,
             functionName: String = #function,
             lineNumber: Int = #line) {

        guard Env.configuration == .debug, shouldLog(type: logType) else { return }

        let message = generateMessage(logType: logType,
                                      logMessage: logMessage,
                                      file: file,
                                      functionName: functionName,
                                      lineNumber: lineNumber)

        queue.async { [weak self] in
            self?.modules.forEach {
                $0.write(message, separator: " ", terminator: "\n\n")
            }
        }
    }

    private func generateMessage(logType: LogType,
                                 logMessage: String?,
                                 file: String,
                                 functionName: String,
                                 lineNumber: Int) -> String {

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

        return message
    }

    private func shouldLog(type: LogType) -> Bool {
        if case let LogLevel.filtered(logType) = logLevel, logType != type {
            return false
        }
        return true
    }
}
