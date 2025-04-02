import XCTest
@testable import imageApp

final class NetworkServiceTest: XCTestCase {

    var sut: MockNetworkService!
    var succes: Result<Data, NetworkServiceErrors> = .success(Data())
    var error: Result<Data, NetworkServiceErrors> = .failure(.unknownError)
    
    override func setUpWithError() throws {
        sut = MockNetworkService()
    }

    override func tearDownWithError() throws {
       sut = nil
    }

    func testSuccess() throws {
        // Given
        sut.resultToReturn = succes
        var actualData: Result<Data, NetworkServiceErrors>!
        // When
        sut.fetchData(urlString: "google.com") { result in
            actualData = result
        }
        // Then
        XCTAssertEqual(actualData, succes)
    }
    func testError() throws {
        // Given
        sut.resultToReturn = error
        var actualData: Result<Data, NetworkServiceErrors>!
        // When
        sut.fetchData(urlString: "google.com") { result in
            actualData = result
        }
        // Then
        XCTAssertEqual(actualData, error)
    }

}
