import Foundation

protocol IDataService: AnyObject {
    var networkService: INetworkService { get }
    var decoderService: IDecoderService { get }
    func initialFetchData(completion: @escaping(Result<[MainScreenModel], Error>) -> Void)
    func fetchMoreData(page: Int, completion: @escaping(Result<[MainScreenModel], Error>) -> Void)
    func searchPhoto(page: Int, query: String, completion: @escaping(Result<[MainScreenModel], Error>) -> Void)
    func fetchDetailInformation(id: String, completion: @escaping(Result<DetailScreenModel, Error>) -> Void)
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
        networkService.fetchData(page: 1, query: nil) { result in
            switch result {
            case .success(let success):
                self.decoderService.decode(
                    networkData: success,
                    completion: { (result: Result<[MainResponseModel], Error>) in
                    switch result {
                    case .success(let successResponse):
                        let mainScreenModelList = successResponse.map { model in
                            let links = Links(raw: model.urls.regular)
                            let user = UserModel(name: model.user.name, surname: model.user.surname ?? "")
                            return MainScreenModel(id: model.id, user: user, likes: model.likes, links: links)
                        }
                        completion(.success(mainScreenModelList))
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
    
    func fetchMoreData(page: Int = 1, completion: @escaping(Result<[MainScreenModel], Error>) -> Void) {
        networkService.fetchData(page: page, query: nil) { result in
            switch result {
            case .success(let success):
                self.decoderService.decode(
                    networkData: success,
                    completion: { (result: Result<[MainResponseModel], Error>) in
                    switch result {
                    case .success(let successResponse):
                        let mainScreenModelList = successResponse.map { model in
                            let links = Links(raw: model.urls.regular)
                            let user = UserModel(name: model.user.name, surname: model.user.surname ?? "")
                            return MainScreenModel(id: model.id, user: user, likes: model.likes, links: links)
                        }
                        completion(.success(mainScreenModelList))
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
    
    func searchPhoto(page: Int = 1 , query: String, completion: @escaping(Result<[MainScreenModel], Error>) -> Void) {
        networkService.fetchData(page: page, query: query) { result in
            switch result {
            case .success(let success):
                self.decoderService.decode(
                    networkData: success,
                    completion: { (result: Result<SearchResponseModel, Error>) in
                    switch result {
                    case .success(let successResponse):
                        let mainScreenModelList = successResponse.results.map { model in
                            let links = Links(raw: model.urls.regular)
                            let user = UserModel(name: model.user.name, surname: model.user.surname ?? "")
                            return MainScreenModel(id: model.id, user: user, likes: model.likes, links: links)
                        }
                        completion(.success(mainScreenModelList))
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
    
    func fetchDetailInformation(id: String, completion: @escaping (Result<DetailScreenModel, Error>) -> Void) {
        networkService.fetchDetailInfo(id: id) { result in
            switch result {
            case .success(let successResponse):
                self.decoderService.decode(networkData: successResponse) { (result: Result<DetailResponseModel, Error>) in
                    switch result {
                    case .success(let successDecode):
                        let detailScreenModel = DetailScreenModel(
                            url: successDecode.links.regular,
                            authorName: successDecode.user.name,
                            authorSurname: successDecode.user.surname ?? "",
                            downloads: successDecode.downloads,
                            creationDate: successDecode.dateOfCreation,
                            location: .init(city: successDecode.location.city, country: successDecode.location.country)
                        )
                        completion(.success(detailScreenModel))
                    case .failure(let failure):
                        completion(.failure(failure))
                    }
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}




