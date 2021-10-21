@testable import Foo
import XCTest

class MessageTests: XCTestCase {
  func test_init() throws {
    let value = "hello"
    let msg = Message(value: value)
    XCTAssertEqual(msg.value, value)
  }
}
