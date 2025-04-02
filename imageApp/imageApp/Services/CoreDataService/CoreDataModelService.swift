import UIKit

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
    
    func addNewModel(_ model: DetailScreenModel, image: UIImage, completion: (Result<Bool, CustomError>) -> Void) {
        guard let modelsArray = self.modelsArray else { return }
        if !modelsArray.contains(where: { $0.id == model.id }) {
            let newModelToSave = FavouriteModel(context: coreDataSerivce.context)
            newModelToSave.id = model.id
            newModelToSave.authorname = model.authorName
            newModelToSave.authorsurname = model.authorSurname
            newModelToSave.city = model.location.city
            newModelToSave.country = model.location.country
            newModelToSave.date = model.creationDate
            newModelToSave.image = image.pngData()
            newModelToSave.numberOfDownloads = Int64(model.downloads)
            coreDataSerivce.saveContext { result in
                switch result {
                case .success(let success):
                    completion(.success(success))
                case .failure(_):
                    completion(.failure(.failedSave))
                }
            }
            initialFetch()
        }
    }
    
    func removeModel(_ model: FavouriteModel, completion: (Result<Bool, CustomError>) -> Void) {
        coreDataSerivce.deleObject(model: model) { result in
            switch result {
            case .success(_):
                initialFetch()
                completion(.success(true))
            case .failure(let failure):
                print(failure.localizedDescription)
                completion(.failure(.failedToDelete))
            }
        }
    }
    
    func returnData() -> [FavouriteModel] {
        initialFetch()
        guard let modelsArray = modelsArray else { return [] }
        return modelsArray
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
