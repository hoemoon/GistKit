import XCTest
@testable import GistKit

final class GistKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GistKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
