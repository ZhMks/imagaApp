import UIKit
// MARK: - presenter
protocol IFavouriteScreenPresenter: AnyObject {
    func returnNumberOfItems() -> Int
    func returnModelList() -> [FavouriteModel]
    func removeFromFavourite(model: FavouriteModel)
}
// MARK: - view input
protocol IFavouriteScreenView: AnyObject {
    func updateData()
    func showDetailScreen(_ controller: UIViewController)
    func showErrorAlert(_ error: Error)
}

final class FavouritePresenter: IFavouriteScreenPresenter {
    // MARK: - properties
    weak var view: IFavouriteScreenView?
    private let coreDataModelService: CoreDataModelService
    private(set) var modelList: [FavouriteModel]?
    // MARK: - lifecycle
    init(coreDataModelService: CoreDataModelService) {
        self.coreDataModelService = coreDataModelService
    }
    
    func viewDidLoad(_ view: IFavouriteScreenView) {
        self.view = view
    }
    
    func initialFetchData() {
        self.modelList = coreDataModelService.returnData()
        view?.updateData()
    }
    func returnNumberOfItems() -> Int {
        guard let modelList = modelList else { return 0 }
        return modelList.count
    }
    
    func returnModelList() -> [FavouriteModel] {
        guard let modelList = modelList else { return [] }
        return modelList
    }
    
    func pushDetailedScreen(with model: FavouriteModel) {
//        guard let modelString = model.url else { return }
//        let detailedModel = DetailScreenModel(url: model.url, authorName: model., authorSurname: <#T##String#>, likes: <#T##Int#>)
//        let detailScreen = ModuleBuilder.createDetailedScreen(model: detailedModel, coreDataService: coreDataModelService)
//        DispatchQueue.main.async {
//            self.view?.showDetailScreen(detailScreen)
//        }
    }
    
    func removeFromFavourite(model: FavouriteModel) {
        coreDataModelService.removeModel(model) { [weak self] result in
            switch result {
            case .success(let success):
                self?.view?.updateData()
            case .failure(let failure):
                self?.view?.showErrorAlert(failure)
            }
        }
    }
}

