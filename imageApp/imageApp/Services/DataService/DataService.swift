import Foundation

protocol IDataService: AnyObject {
    var networkService: INetworkService { get }
    var decoderService: IDecoderService { get }
    func initialFetchData(completion: @escaping(Result<[MainScreenModel], Error>) -> Void)
    func fetchMoreData(completion: @escaping(Result<[MainScreenModel], Error>) -> Void)
}
final class DataService: IDataService {
    // MARK: - Properties
    private(set) var networkService: INetworkService
    private(set) var decoderService: IDecoderService
    // MARK: - Lifecycle
    init(
        networkService: INetworkService,
        decoderService: IDecoderService
    ) {
        self.networkService = networkService
        self.decoderService = decoderService
    }
    // MARK: - Funcs
    func initialFetchData(completion: @escaping(Result<[MainScreenModel], Error>) -> Void) {
        networkService.fetchData(page: nil) { result in
            switch result {
            case .success(let success):
                print(String(data: success, encoding: .utf8))
//                self.decoderService.decode(
//                    networkData: success,
//                    completion: { (result: Result<MainResponseModel, Error>) in
//                    switch result {
//                    case .success(let successResponse):
//                        return
//                    case .failure(let failure):
//                        completion(.failure(failure))
//                    }
//                }
//            )
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    func fetchMoreData(completion: @escaping(Result<[MainScreenModel], Error>) -> Void) {
        networkService.fetchData(page: "next") { result in
            switch result {
            case .success(let success):
                self.decoderService.decode(
                    networkData: success,
                    completion: { (result: Result<MainResponseModel, Error>) in
                    switch result {
                    case .success(let successResponse):
                        return
                    case .failure(let failure):
                        completion(.failure(failure))
                    }
                }
            )
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}




