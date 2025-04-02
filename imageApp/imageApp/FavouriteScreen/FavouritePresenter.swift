import UIKit
// MARK: - presenter
protocol IFavouriteScreenPresenter: AnyObject {
    func returnNumberOfItems() -> Int
    func returnModelList() -> [FavouriteModel]
    func initialFetchData()
    func pushDetailedScreen(with model: FavouriteModel)
    func viewDidLoad(_ view: IFavouriteScreenView)
    func removeFromFavourites(model: FavouriteModel)
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
    private(set) var modelList: [FavouriteModel] = []
    private let dataService: IDataService
    // MARK: - lifecycle
    init(coreDataModelService: CoreDataModelService, dataService: IDataService) {
        self.coreDataModelService = coreDataModelService
        self.dataService = dataService
    }
    
    func viewDidLoad(_ view: IFavouriteScreenView) {
        self.view = view
    }
    
    func initialFetchData() {
        self.modelList = coreDataModelService.returnData()
        view?.updateData()
    }
    
    func returnNumberOfItems() -> Int {
        return modelList.count
    }
    
    func returnModelList() -> [FavouriteModel] {
        return modelList
    }
    
    func pushDetailedScreen(with model: FavouriteModel) {
        let detailScreen = ModuleBuilder.createDetailedScreen(
            id: model.id ?? "",
            coreDataService: coreDataModelService,
            dataService: dataService,
            isfromFavourite: true
        )
        DispatchQueue.main.async {
            self.view?.showDetailScreen(detailScreen)
        }
    }
    
    func removeFromFavourites(model: FavouriteModel) {
        coreDataModelService.removeModel(model) { [weak self] result in
            switch result {
            case .success(_):
                self?.initialFetchData()
            case .failure(let failure):
                self?.view?.showErrorAlert(failure)
            }
        }
    }
}

