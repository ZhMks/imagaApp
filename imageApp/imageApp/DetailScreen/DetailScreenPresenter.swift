import UIKit
// MARK: - presenter
protocol IDetailScreenPresenter: AnyObject {
    func viewDidLoad(_ view: IDetailScreenView)
}
// MARK: - view input
protocol IDetailScreenView: AnyObject {
    func updateData(_ model: DetailScreenModel)
}

final class DetailScreenPresenter: IDetailScreenPresenter {
    // MARK: - properties
    weak var view: IDetailScreenView?
    private(set) var model: DetailScreenModel
    // MARK: - lifecycle
    init( model: DetailScreenModel) {
        self.model = model
    }
    
    func viewDidLoad(_ view: IDetailScreenView) {
        self.view = view
        updateData()
    }
}
// MARK: - private funcs
extension DetailScreenPresenter {
    func updateData() {
        view?.updateData(model)
    }
}
