import Foundation

protocol IDecoderService {
    func decode<T:Codable>(networkData: Data, completion: (Result<T, Error>) -> Void)
}

final class DecoderService: IDecoderService {
    func decode<T:Codable>(networkData: Data, completion: (Result<T, Error>) -> Void) {
        let decoder = JSONDecoder()
        do {
            let networkModel = try decoder.decode(T.self, from: networkData)
            completion(.success(networkModel))
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            completion(.failure(error))
        }
    }
}



