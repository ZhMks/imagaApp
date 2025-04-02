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
    func fetchData(page: Int, query: String?, completion: @escaping (Result<Data, NetworkServiceErrors>) -> Void)
    func fetchDetailInfo(id: String, completion: @escaping (Result<Data, NetworkServiceErrors>) -> Void)
}
final class NetworkService: INetworkService {
    var isLoading = false
    let key = "Y85J2c5RV5FKn_XA-9Pjs4nsi0nB8IEdQOHWdFBgqkw"
    
    func fetchData(page: Int = 1, query: String?, completion: @escaping (Result<Data, NetworkServiceErrors>) -> Void) {
        var urlString = ""
        if isLoading {
            return
        }
        if let query = query {
            isLoading = true
            urlString = "https://api.unsplash.com/search/photos?page=\(page)&query=\(query)&client_id=\(key)"
        } else {
            isLoading = true
            urlString = "https://api.unsplash.com/photos/?client_id=\(key)&page=\(page)"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest)  { data, response, error in
            if let _ = error {
                self.isLoading = false
                completion(.failure(.unknownError))
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 403:
                    self.isLoading = false
                    completion(.failure(.unknownError))
                case 404:
                    self.isLoading = false
                    completion(.failure(.pageNotFound))
                case 500:
                    self.isLoading = false
                    completion(.failure(.internalServerError))
                case 200:
                    if let data = data {
                        self.isLoading = false
                        completion(.success(data))
                    }
                default:
                    self.isLoading = false
                    completion(.failure(.unknownError))
                }
            }
        }.resume()
    }
    
    func fetchDetailInfo(id: String, completion: @escaping (Result<Data, NetworkServiceErrors>) -> Void) {
        let urlString = "https://api.unsplash.com/photos/\(id)?client_id=Y85J2c5RV5FKn_XA-9Pjs4nsi0nB8IEdQOHWdFBgqkw"
        
        guard let url = URL(string: urlString) else { return }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest)  { data, response, error in
            if let _ = error {
                self.isLoading = false
                completion(.failure(.unknownError))
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 403:
                    self.isLoading = false
                    completion(.failure(.unknownError))
                case 404:
                    self.isLoading = false
                    completion(.failure(.pageNotFound))
                case 500:
                    self.isLoading = false
                    completion(.failure(.internalServerError))
                case 200:
                    if let data = data {
                        self.isLoading = false
                        completion(.success(data))
                    }
                default:
                    self.isLoading = false
                    completion(.failure(.unknownError))
                }
            }
        }.resume()
    }
}
