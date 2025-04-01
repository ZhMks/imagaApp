import Foundation

enum CustomError: Error {
    case failedSave
    case failedToDelete
    
    var descritpion: String {
        switch self {
        case .failedSave:
            return "Не удалось сохранить модель"
        case .failedToDelete:
            return "Не удалось удалить модель"
        }
    }
}

final class CoreDataModelService {
    private(set) var modelsArray: [FavouriteModel]?
    private let coreDataSerivce = CoreDataService.shared
    
    init() {
        initialFetch()
    }
    
    func addNewModel(_ model: FavouriteViewModel) {
        guard let modelsArray = self.modelsArray else { return }
        if modelsArray.contains(where: { $0.objectID != model.objectID }) {
            let newModelToSave = FavouriteModel(context: coreDataSerivce.context)
            coreDataSerivce.saveContext()
            initialFetch()
        }
    }
    
    func removeModel(_ model: FavouriteModel, completion: (Result<Bool, CustomError>) -> Void) {
        coreDataSerivce.deleObject(model: model) { result in
            switch result {
            case .success(let success):
                initialFetch()
                completion(.success(true))
            case .failure(let failure):
                print(failure.localizedDescription)
                completion(.failure(.failedToDelete))
            }
        }
    }
}
// MARK: - private funcs
extension CoreDataModelService {
    func initialFetch() {
        let fetchRequest = FavouriteModel.fetchRequest()
        do {
            modelsArray = try coreDataSerivce.context.fetch(fetchRequest)
        } catch {
            modelsArray = []
            print(error.localizedDescription)
        }
    }
}
