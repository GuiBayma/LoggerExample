import XCTest
@testable import Logger

class ConsoleWriterMock: WriterProtocol {
    var output: String?

    func write(_ items: Any..., separator: String, terminator: String) {
        output = items.map { "\($0)" }.joined(separator: separator)
    }
}

class ConsoleWriterTests: XCTestCase {

    var sut: Logger!
    var testQueue: DispatchQueue!
    var consoleWriterMock: ConsoleWriterMock!

    override func setUp() {
        super.setUp()
        testQueue = DispatchQueue(label: "TestQueue")
        consoleWriterMock = ConsoleWriterMock()
    }

    override func tearDown() {
        super.tearDown()
        Logger.resetInstance()
    }

    func testAppDelegateVerbose() {
        Logger.setup(queue: testQueue, modules: [consoleWriterMock], logLevel: .verbose)
        sut = Logger.shared

        sut.log(.appDelegate)
        testQueue.sync {}

        XCTAssertNotNil(consoleWriterMock.output)
    }

    func testAppDelegateMessageVerbose() {
        Logger.setup(queue: testQueue, modules: [consoleWriterMock], logLevel: .verbose)
        sut = Logger.shared

        sut.log(.appDelegate, "Test Message")
        testQueue.sync {}

        XCTAssertNotNil(consoleWriterMock.output)
    }

    func testAppDelegateFileredAppDelegate() {
        Logger.setup(queue: testQueue, modules: [consoleWriterMock], logLevel: .filtered(.appDelegate))
        sut = Logger.shared

        sut.log(.appDelegate)
        testQueue.sync {}

        XCTAssertNotNil(consoleWriterMock.output)
    }

    func testAppDelegateFileredController() {
        Logger.setup(queue: testQueue, modules: [consoleWriterMock], logLevel: .filtered(.controller))
        sut = Logger.shared

        sut.log(.appDelegate)
        testQueue.sync {}

        XCTAssertNil(consoleWriterMock.output)
    }

    func testControllerVerbose() {
        Logger.setup(queue: testQueue, modules: [consoleWriterMock], logLevel: .verbose)
        sut = Logger.shared

        sut.log(.controller)
        testQueue.sync {}

        XCTAssertNotNil(consoleWriterMock.output)
    }

    func testControllerMessageVerbose() {
        Logger.setup(queue: testQueue, modules: [consoleWriterMock], logLevel: .verbose)
        sut = Logger.shared

        sut.log(.controller, "Test Message")
        testQueue.sync {}

        XCTAssertNotNil(consoleWriterMock.output)
    }

    func testControllerFileredAppDelegate() {
        Logger.setup(queue: testQueue, modules: [consoleWriterMock], logLevel: .filtered(.appDelegate))
        sut = Logger.shared

        sut.log(.controller)
        testQueue.sync {}

        XCTAssertNil(consoleWriterMock.output)
    }

    func testControllerFileredAppController() {
        Logger.setup(queue: testQueue, modules: [consoleWriterMock], logLevel: .filtered(.controller))
        sut = Logger.shared

        sut.log(.controller)
        testQueue.sync {}

        XCTAssertNotNil(consoleWriterMock.output)
    }
}
