import XCTest
@testable import Logger

class ConsoleWriterMock: ConsoleWriterProtocol {
    var output: String?

    func print(_ items: Any..., separator: String, terminator: String) {
        output = items.map { "\($0)" }.joined(separator: separator)
    }
}

class LoggerTests: XCTestCase {

    var sut: Logger!
    var testQueue: DispatchQueue!
    var writerMock: ConsoleWriterMock!

    override func setUp() {
        super.setUp()
        testQueue = DispatchQueue(label: "TestQueue")
        writerMock = ConsoleWriterMock()
    }

    override func tearDown() {
        super.tearDown()
        Logger.resetInstance()
    }

    func testAppDelegateVerbose() {
        Logger.setup(queue: testQueue, writer: writerMock, logLevel: .verbose)
        sut = Logger.shared

        sut.log(.appDelegate)
        testQueue.sync {}

        XCTAssertNotNil(writerMock.output)
    }

    func testAppDelegateMessageVerbose() {
        Logger.setup(queue: testQueue, writer: writerMock, logLevel: .verbose)
        sut = Logger.shared

        sut.log(.appDelegate, "Test Message")
        testQueue.sync {}

        XCTAssertNotNil(writerMock.output)
    }

    func testAppDelegateFileredAppDelegate() {
        Logger.setup(queue: testQueue, writer: writerMock, logLevel: .filtered(.appDelegate))
        sut = Logger.shared

        sut.log(.appDelegate)
        testQueue.sync {}

        XCTAssertNotNil(writerMock.output)
    }

    func testAppDelegateFileredController() {
        Logger.setup(queue: testQueue, writer: writerMock, logLevel: .filtered(.controller))
        sut = Logger.shared

        sut.log(.appDelegate)
        testQueue.sync {}

        XCTAssertNil(writerMock.output)
    }

    func testControllerVerbose() {
        Logger.setup(queue: testQueue, writer: writerMock, logLevel: .verbose)
        sut = Logger.shared

        sut.log(.controller)
        testQueue.sync {}

        XCTAssertNotNil(writerMock.output)
    }

    func testControllerMessageVerbose() {
        Logger.setup(queue: testQueue, writer: writerMock, logLevel: .verbose)
        sut = Logger.shared

        sut.log(.controller, "Test Message")
        testQueue.sync {}

        XCTAssertNotNil(writerMock.output)
    }

    func testControllerFileredAppDelegate() {
        Logger.setup(queue: testQueue, writer: writerMock, logLevel: .filtered(.appDelegate))
        sut = Logger.shared

        sut.log(.controller)
        testQueue.sync {}

        XCTAssertNil(writerMock.output)
    }

    func testControllerFileredAppController() {
        Logger.setup(queue: testQueue, writer: writerMock, logLevel: .filtered(.controller))
        sut = Logger.shared

        sut.log(.controller)
        testQueue.sync {}

        XCTAssertNotNil(writerMock.output)
    }
}
