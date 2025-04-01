import Foundation
@testable import imageApp

final class MockDecoderService: IDecoderService {
    var resultToReturn: Any?

    func decode<T: Codable>(networkData: Data, completion: (Result<T, Error>) -> Void) {
        if let result = resultToReturn as? Result<T, Error> {
            completion(result)
        } else {
            let error = NSError(domain: "TestError", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
}
