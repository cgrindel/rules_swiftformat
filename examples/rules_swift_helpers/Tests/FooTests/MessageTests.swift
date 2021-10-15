@testable import Foo
import XCTest

class MessageTests: XCTestCase {
  func test_init() throws {
    let value = "hello"
    let msg = Messsage(value = value)
    XCTAssertEqual(msg.value, value)
  }
}
