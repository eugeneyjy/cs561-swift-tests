import XCTest
@testable import MyLibrary

final class WeatherServiceTests: XCTestCase {
    func testWeatherModel() async throws {
        // Given
        let filePath = try XCTUnwrap(Bundle.module.path(forResource: "data", ofType: "json"))
        let jsonString = try String(contentsOfFile: filePath)
        let jsonData = Data(jsonString.utf8)
        let jsonDecoder = JSONDecoder()

        // When
        let weather = try jsonDecoder.decode(Weather.self, from: jsonData)

        // Then
        XCTAssertNotNil(weather)
        XCTAssert(weather.main.temp == 286.71)
        XCTAssert(weather.main.temp != 286)
    }
}
