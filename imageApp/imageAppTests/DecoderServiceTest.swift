import XCTest
@testable import imageApp

struct SampleModel: Codable, Equatable {
    let id: Int
    let name: String
    let text: String
    let isFinished: Bool
}

final class DecoderServiceTests: XCTestCase {
    var sut: MockDecoderService!
    
    override func setUp() {
        super.setUp()
        sut = MockDecoderService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDecode_Success() {
        // Given
        let expectedModel = SampleModel(id: 1, name: "Test", text: "Test", isFinished: false)
        sut.resultToReturn = Result<SampleModel, Error>.success(expectedModel)
        var receivedResult: Result<SampleModel, Error>?
        // When
        sut.decode(networkData: Data()) { (result: Result<SampleModel, Error>) in
            receivedResult = result
        }
        // Then
        switch receivedResult {
        case .success(let model):
            XCTAssertEqual(model, expectedModel)
        case .failure:
            XCTFail("Decoding should not fail")
        case .none:
            XCTFail("Completion handler was not called")
        }
    }
    
    func testDecode_Failure() {
        let error = NSError(domain: "TestError", code: 0, userInfo: nil)
        sut.resultToReturn = Result<SampleModel, Error>.failure(error)
        var receivedResult: Result<SampleModel, Error>?
        // When
        sut.decode(networkData: Data()) { (result: Result<SampleModel, Error>) in
            receivedResult = result
        }
        // Then
        switch receivedResult {
        case .success:
            XCTFail("Decoding should fail")
        case .failure(let receivedError):
            XCTAssertEqual((receivedError as NSError).domain, "TestError")
        case .none:
            XCTFail("Completion handler was not called")
        }
    }
}
