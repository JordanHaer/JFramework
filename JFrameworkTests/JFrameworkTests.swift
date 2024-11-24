import XCTest
import JFramework

final class JFrameworkTests: XCTestCase {

    func test_test() {
        XCTAssertEqual(Framework.name, "JFramework")
        XCTAssertEqual(Framework.version, "0.0.1")
    }
}
