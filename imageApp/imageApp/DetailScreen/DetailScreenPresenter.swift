import UIKit
// MARK: - presenter
protocol IDetailScreenPresenter: AnyObject {
    func viewDidLoad(_ view: IDetailScreenView)
    func popController()
    func addToFavourites()
}
// MARK: - view input
protocol IDetailScreenView: AnyObject {
    func updateData(_ model: DetailScreenModel)
    func popController()
}

final class DetailScreenPresenter: IDetailScreenPresenter {
    // MARK: - properties
    weak var view: IDetailScreenView?
    private(set) var model: DetailScreenModel
    private let coreDataService: CoreDataModelService
    // MARK: - lifecycle
    init( model: DetailScreenModel, coreDataService: CoreDataModelService) {
        self.model = model
        self.coreDataService = coreDataService
    }
    
    func viewDidLoad(_ view: IDetailScreenView) {
        self.view = view
        updateData()
    }
    
    func popController() {
        view?.popController()
    }
    
    func addToFavourites() {
        coreDataService.addNewModel(model)
    }
}
// MARK: - private funcs
extension DetailScreenPresenter {
    func updateData() {
        view?.updateData(model)
    }
}
