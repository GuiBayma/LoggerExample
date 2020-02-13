import Foundation

final class Logger {

    static private var sharedInstance: Logger?

    static var shared: Logger {
        guard let sharedInstance = sharedInstance else {
            fatalError("Logger: call setup() first")
        }
        return sharedInstance
    }

    static func setup(queue: DispatchQueue = DispatchQueue.init(label: "logger")) {
        if sharedInstance == nil {
            sharedInstance = Logger(queue: queue)
        }
    }

    private init(queue: DispatchQueue) {
        self.queue = queue
    }

    private var queue: DispatchQueue

    func log(_ logType: LogType,
             _ logMessage: String? = nil,
             file: String = #file,
             functionName: String = #function,
             lineNumber: Int = #line) {

        guard Env.configuration == .debug else { return }

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
}
