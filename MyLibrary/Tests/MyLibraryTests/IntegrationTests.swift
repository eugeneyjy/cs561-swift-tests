import XCTest
@testable import MyLibrary

final class IntegrationTests: XCTestCase {
    func testIntegrateWithMock() async throws {
        // Given
        let myLibrary = MyLibrary()

        // When
        let isLuckyNumber = await myLibrary.isLucky(0)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        // temp in mock server is 294.72, resulting isLuckyNumber = false
        XCTAssert(isLuckyNumber == false)
    }

    func testIntegrateWithProd() async throws {
        // Given
        let prodWeatherService = WeatherServiceImpl(prod: true)
        let myLibrary = MyLibrary(weatherService: prodWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(0)

        //Then
        XCTAssertNotNil(isLuckyNumber)
        // Can't really test if isLuckyNumber is true or false
        // Since production results are dynamic
    }
}