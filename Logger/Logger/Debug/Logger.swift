import Foundation

final class Logger {

    class func log(_ logType: LogType,
                   _ logMessage: String? = nil,
                   file: String = #file,
                   functionName: String = #function,
                   lineNumber: Int = #line) {

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

        print(message)
    }
}
