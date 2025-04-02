import UIKit
// MARK: - presenter
protocol IDetailScreenPresenter: AnyObject {
    func viewDidLoad(_ view: IDetailScreenView)
    func popController()
    func addToFavourites()
    func fetchDetailInformation()
}
// MARK: - view input
protocol IDetailScreenView: AnyObject {
    func updateData(_ model: DetailScreenModel)
    func popController()
    func showErrorAlert(_ error: Error)
}

final class DetailScreenPresenter: IDetailScreenPresenter {
    // MARK: - properties
    weak var view: IDetailScreenView?
    private let mainModel: MainScreenModel
    private let coreDataService: CoreDataModelService
    private let dataService: IDataService
    private(set) var detailedModel: DetailScreenModel?
    // MARK: - lifecycle
    init(model: MainScreenModel, coreDataService: CoreDataModelService, dataService: IDataService) {
        self.mainModel = model
        self.coreDataService = coreDataService
        self.dataService = dataService
    }
    
    func viewDidLoad(_ view: IDetailScreenView) {
        self.view = view
        updateData()
    }
    
    func popController() {
        view?.popController()
    }
    
    func fetchDetailInformation() {
        dataService.fetchDetailInformation(id: mainModel.id) { [weak self] result in
            switch result {
            case .success(let success):
                self?.detailedModel = success
                self?.updateData()
            case .failure(let failure):
                self?.view?.showErrorAlert(failure)
            }
        }
    }
    
    func addToFavourites() {
       // coreDataService.addNewModel(mainModel)
    }
}
// MARK: - private funcs
extension DetailScreenPresenter {
    func updateData() {
        guard let detailedModel = detailedModel else { return }
        DispatchQueue.main.async {
            self.view?.updateData(detailedModel)
        }
    }
}
