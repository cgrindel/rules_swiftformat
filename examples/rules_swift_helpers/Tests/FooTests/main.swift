#if os(Linux)
  import XCTest

  XCTMain([
    testCase(MessageTests.allTests),
  ])
#endif
