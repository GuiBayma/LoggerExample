import Foundation

final class ConsoleWriter: WriterProtocol {

    func write(_ items: Any..., separator: String, terminator: String) {
        let output = items.map { "\($0)" }.joined(separator: separator)
        Swift.print(output, terminator: terminator)
    }
}
