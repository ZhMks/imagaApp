import UIKit
// MARK: - presenter protocol
protocol IMainScreePresenter: AnyObject {
    func pushDetailsScreen(model: MainScreenModel)
    func viewDidLoad(_ view: IMainScreenView)
    func returnNumberOfItems() -> Int
    func returnImageList() -> [MainScreenModel]
    func fetchMoreImages()
    func fetchData()
}
// MARK: - view protocol
protocol IMainScreenView: AnyObject {
    func showDetailScreen(_ controller: UIViewController)
    func updateData()
    func showErrorAlert(_ error: Error)
}
// MARK: - presenter
final class MainScreenPresenter: IMainScreePresenter {
    // MARK: - properties
    weak var view: IMainScreenView?
    var filteredList: [MainScreenModel]?
    private var model: [MainScreenModel] = []
    private let dataService: IDataService
    // MARK: - lifecycle
    init(dataService: IDataService) {
        self.dataService = dataService
    }
    // MARK: - funcs
    func viewDidLoad(_ view: IMainScreenView) {
        self.view = view
    }
    
    func pushDetailsScreen(model: MainScreenModel) {
        let detailedModel = DetailScreenModel(url: model.url)
        let coredataService = CoreDataModelService()
        let detailScreen = ModuleBuilder.createDetailedScreen(model: detailedModel, coreDataService: coredataService)
        self.view?.showDetailScreen(detailScreen)
    }
    
    func fetchData() {
        dataService.initialFetchData() { [weak self] result in
            switch result {
            case .success(let success):
                self?.model = success
                self?.filteredList = success
                self?.view?.updateData()
            case .failure(let failure):
                print()
                self?.view?.showErrorAlert(failure)
            }
        }
    }
    
    func returnNumberOfItems() -> Int {
        guard let filteredList = filteredList else { return 0 }
        return filteredList.count
    }
    
    func returnImageList() -> [MainScreenModel] {
        guard let filteredList = filteredList else { return [] }
        return filteredList
    }
    
    func searchInformation(text: String) {
        
    }
    
    func fetchMoreImages() {
        dataService.fetchMoreData { [weak self] result in
            switch result {
            case .success(let success):
                self?.model.append(contentsOf: success)
                self?.filteredList = self?.model
                self?.view?.updateData()
            case .failure(let failure):
                self?.view?.showErrorAlert(failure)
            }
        }
    }
}
