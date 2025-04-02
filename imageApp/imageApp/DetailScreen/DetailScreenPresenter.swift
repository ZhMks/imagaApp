import UIKit
// MARK: - presenter
protocol IDetailScreenPresenter: AnyObject {
    func viewDidLoad(_ view: IDetailScreenView)
    func popController()
    func addToFavourites(image: UIImage)
    func fetchDetailInformation()
    func isModelInfavourite() -> Bool
    func removeFromFavourites()
}
// MARK: - view input
protocol IDetailScreenView: AnyObject {
    func updateData(_ model: DetailScreenModel)
    func popController()
    func showErrorAlert(_ error: Error)
    func performAnimation()
}

final class DetailScreenPresenter: IDetailScreenPresenter {
    // MARK: - properties
    weak var view: IDetailScreenView?
    private let coreDataService: CoreDataModelService
    private let dataService: IDataService
    private(set) var detailedModel: DetailScreenModel?
    private let id: String
    private let isFromFavourite: Bool
    // MARK: - lifecycle
    init(id: String, coreDataService: CoreDataModelService, dataService: IDataService, isFromFavourite: Bool) {
        self.coreDataService = coreDataService
        self.dataService = dataService
        self.id = id
        self.isFromFavourite = isFromFavourite
    }
    
    func viewDidLoad(_ view: IDetailScreenView) {
        self.view = view
        updateData()
    }
    
    func popController() {
        view?.popController()
    }
    
    func fetchDetailInformation() {
        if isFromFavourite {
            let coreDataModelList = coreDataService.returnData()
            self.detailedModel = coreDataModelList.filter { $0.id == id }.first.map(
                { model in
                    DetailScreenModel(
                        id: model.id ?? "",
                        url: nil,
                        authorName: model.authorname ?? "",
                        authorSurname: model.authorsurname ?? "",
                        downloads: Int(model.numberOfDownloads),
                        creationDate: model.date ?? "",
                        location: .init(city: model.city, country: model.country),
                        image: UIImage(data: model.image ?? Data())
                    )
            })
            updateData()
        } else {
            dataService.fetchDetailInformation(id: id) { [weak self] result in
                switch result {
                case .success(let success):
                    self?.detailedModel = success
                    self?.updateData()
                case .failure(let failure):
                    self?.view?.showErrorAlert(failure)
                }
            }
        }
    }
    
    func addToFavourites(image: UIImage) {
        guard let detailedModel = detailedModel else { return }
        coreDataService.addNewModel(detailedModel, image: image) { [weak self] result in
            switch result {
            case .success(_):
                self?.view?.performAnimation()
            case .failure(let failure):
                self?.view?.showErrorAlert(failure)
            }
        }
    }
    
    func removeFromFavourites() {
        let coreDataModelList = coreDataService.returnData()
        guard let model = coreDataModelList.filter({ $0.id == id }).first else { return }
        coreDataService.removeModel(model) { [weak self] result in
            switch result {
            case .success(_):
                self?.view?.popController()
            case .failure(let failure):
                self?.view?.showErrorAlert(failure)
            }
        }
    }
    
    func isModelInfavourite() -> Bool {
        return self.isFromFavourite
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
