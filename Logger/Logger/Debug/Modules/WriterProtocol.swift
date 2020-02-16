import Foundation

protocol WriterProtocol {
    func write(_ items: Any..., separator: String, terminator: String)
}
