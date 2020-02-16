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

    // MARK: - AppDelegate

    func testAppDelegateVerbose() {
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

    func testAppDelegateFileredSceneDelegate() {
        Logger.setup(queue: testQueue, modules: [consoleWriterMock], logLevel: .filtered(.sceneDelegate))
        sut = Logger.shared

        sut.log(.appDelegate)
        testQueue.sync {}

        XCTAssertNil(consoleWriterMock.output)
    }

    func testAppDelegateFileredController() {
        Logger.setup(queue: testQueue, modules: [consoleWriterMock], logLevel: .filtered(.controller))
        sut = Logger.shared

        sut.log(.appDelegate)
        testQueue.sync {}

        XCTAssertNil(consoleWriterMock.output)
    }

    // MARK: - SceneDelegate

    func testSceneDelegateVerbose() {
        Logger.setup(queue: testQueue, modules: [consoleWriterMock], logLevel: .verbose)
        sut = Logger.shared

        sut.log(.sceneDelegate, "Test Message")
        testQueue.sync {}

        XCTAssertNotNil(consoleWriterMock.output)
    }

    func testSceneDelegateFileredAppDelegate() {
        Logger.setup(queue: testQueue, modules: [consoleWriterMock], logLevel: .filtered(.appDelegate))
        sut = Logger.shared

        sut.log(.sceneDelegate)
        testQueue.sync {}

        XCTAssertNil(consoleWriterMock.output)
    }

    func testSceneDelegateFileredSceneDelegate() {
        Logger.setup(queue: testQueue, modules: [consoleWriterMock], logLevel: .filtered(.sceneDelegate))
        sut = Logger.shared

        sut.log(.sceneDelegate)
        testQueue.sync {}

        XCTAssertNotNil(consoleWriterMock.output)
    }

    func testSceneDelegateFileredController() {
        Logger.setup(queue: testQueue, modules: [consoleWriterMock], logLevel: .filtered(.controller))
        sut = Logger.shared

        sut.log(.sceneDelegate)
        testQueue.sync {}

        XCTAssertNil(consoleWriterMock.output)
    }

    // MARK: - Controller

    func testControllerVerbose() {
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

    func testControllerFileredSceneDelegate() {
        Logger.setup(queue: testQueue, modules: [consoleWriterMock], logLevel: .filtered(.sceneDelegate))
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
