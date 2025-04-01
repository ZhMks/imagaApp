import Foundation

enum NetworkServiceErrors: String, Error {
    case pageNotFound
    case internalServerError
    case unknownError
    
    var description: String {
        switch self {
        case .pageNotFound:
            return "Страница не найдена"
        case .internalServerError:
            return "Ошибка сервера"
        case .unknownError:
            return "Неизвестная ошибка"
        }
    }
}
protocol INetworkService {
    func fetchData(page: String?, completion: @escaping (Result<Data, NetworkServiceErrors>) -> Void)
}
final class NetworkService: INetworkService {
    var isPaginating = false
    
    func fetchData(page: String?, completion: @escaping (Result<Data, NetworkServiceErrors>) -> Void) {
        var urlString = ""
        if isPaginating {
            print("IS PAGINATING: \(isPaginating)")
            return
        }
        if let page = page {
            isPaginating = true
            urlString = "https://api.unsplash.com/photos/?client_id=Y85J2c5RV5FKn_XA-9Pjs4nsi0nB8IEdQOHWdFBgqkw"
        } else {
           urlString = "https://api.unsplash.com/photos/?client_id=Y85J2c5RV5FKn_XA-9Pjs4nsi0nB8IEdQOHWdFBgqkw"
        }
        guard let url = URL(string: urlString) else { return }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest)  { data, response, error in
            if let _ = error {
                self.isPaginating = false
                completion(.failure(.unknownError))
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 403:
                    self.isPaginating = false
                    completion(.failure(.unknownError))
                case 404:
                    self.isPaginating = false
                    completion(.failure(.pageNotFound))
                case 500:
                    self.isPaginating = false
                    completion(.failure(.internalServerError))
                case 200:
                    if let data = data {
                        self.isPaginating = false
                        completion(.success(data))
                    }
                default:
                    self.isPaginating = false
                    completion(.failure(.unknownError))
                }
            }
        }.resume()
    }
}
