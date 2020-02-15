import Foundation

protocol ConsoleWriterProtocol {
    func print(_ items: Any..., separator: String, terminator: String)
}

final class ConsoleWriter: ConsoleWriterProtocol {

    func print(_ items: Any..., separator: String, terminator: String) {
        let output = items.map { "\($0)" }.joined(separator: separator)
        Swift.print(output, terminator: terminator)
    }
}
