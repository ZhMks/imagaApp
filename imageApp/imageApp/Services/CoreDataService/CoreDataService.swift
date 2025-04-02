import Foundation
import CoreData

final class CoreDataService {
    static let shared = CoreDataService()
    
    private init() {}
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "imageApp")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Cannot load PersistentContainer")
            }
        }
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    func saveContext(completion: (Result<Bool, Error>) -> Void) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion(.success(true))
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func deleObject(model: FavouriteModel,completion: (Result<Bool, Error>) -> Void) {
        do {
            let objectToDelete = try context.existingObject(with: model.objectID)
            context.delete(objectToDelete)
            try context.save()
            completion(.success(true))
        } catch {
            print("Failed to delete object: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
}

