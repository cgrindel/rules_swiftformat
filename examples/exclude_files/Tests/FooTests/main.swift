#if os(Linux)
  import XCTest

  XCTMain([
    testCase(MessageTests.allTests),
    testCase(PoorlyFormattedTests.allTests),
  ])
#endif
