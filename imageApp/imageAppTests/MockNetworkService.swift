import Foundation
@testable import imageApp

final class MockNetworkService: INetworkService {
    var resultToReturn: Result<Data, NetworkServiceErrors>?
    
    func fetchData(urlString: String, completion: @escaping (Result<Data, NetworkServiceErrors>) -> Void) {
        if let result = resultToReturn {
            completion(result)
        } else {
            completion(.failure(.unknownError))
        }
    }
}

