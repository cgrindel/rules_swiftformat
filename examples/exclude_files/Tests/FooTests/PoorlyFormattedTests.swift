@testable import Foo
import XCTest

    // Purposely poorly formatted.
    class PoorlyFormattedTests: XCTestCase {
        func test_init() throws {
            let value = "hello"
            var pfmt = PoorlyFormatted()
            pfmt.name = value
            XCTAssertEqual(pfmt.name, value)
        }
    }
