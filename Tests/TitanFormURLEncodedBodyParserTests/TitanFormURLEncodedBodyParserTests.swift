import XCTest
import TitanFormURLEncodedBodyParser
import TitanCore

class TitanFormURLEncodedBodyParserTests: XCTestCase {
    func testExample() {
      let requestBody = "foo=bar&baz=&favorite+flavor=flies&resume=when+i+was+young%0D%0Ai+went+to+school&foo=bar2"
      let request = Request("POST", "/submit", requestBody, headers: [])
      let parsed = request.formURLEncodedBody
      // Simple
      XCTAssertEqual(parsed[0].key, "foo")
      XCTAssertEqual(parsed[0].value, "bar")
      // Missing value
      XCTAssertEqual(parsed[1].key, "baz")
      XCTAssertEqual(parsed[1].value, "")
      // Spaces
      XCTAssertEqual(parsed[2].key, "favorite flavor")
      XCTAssertEqual(parsed[2].value, "flies")
      // Percent encoded new lines
      XCTAssertEqual(parsed[3].key, "resume")
      XCTAssertEqual(parsed[3].value, "when i was young\r\ni went to school")
      // Simple
      XCTAssertEqual(parsed[4].key, "foo")
      XCTAssertEqual(parsed[4].value, "bar2")

      let dict = request.postParams
      XCTAssertEqual(dict["resume"], "when i was young\r\ni went to school")
      XCTAssertEqual(dict["foo"], "bar2") // check repeats, last value wins
    }


    static var allTests : [(String, (TitanFormURLEncodedBodyParserTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
