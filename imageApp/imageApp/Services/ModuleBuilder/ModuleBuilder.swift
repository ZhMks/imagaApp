import UIKit

final class ModuleBuilder {
    static func createMainTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        let coreDataService = CoreDataModelService()
        let networkService = NetworkService()
        let decoderService = DecoderService()
        let dataService = DataService(networkService: networkService, decoderService: decoderService)
        let mainScreen = createMainScreen(coreDataService, dataService: dataService)
        let favouriteScreen = createFavouriteScreen(coreDataService, dataService: dataService)
        let mainNavigationController = UINavigationController(rootViewController: mainScreen)
        let favouriteNavigationController = UINavigationController(rootViewController: favouriteScreen)
        tabBar.viewControllers = [mainNavigationController, favouriteNavigationController]
        tabBar.selectedIndex = 0
        tabBar.tabBar.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.5)
        return tabBar
    }
    
    static func createMainScreen(
        _ coreDataService: CoreDataModelService,
        dataService: IDataService
    ) -> UIViewController {
        let presenter = MainScreenPresenter(dataService: dataService)
        let mainScreen = MainScreenViewController(presenter: presenter)
        let leftTabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "photo"), tag: 0)
        leftTabBarItem.selectedImage = UIImage(systemName: "photo.fill")
        mainScreen.tabBarItem = leftTabBarItem
        return mainScreen
    }
    
    static func createFavouriteScreen(
        _ coreDataService: CoreDataModelService,
        dataService: IDataService
    ) -> UIViewController {
        let presenter = FavouritePresenter(coreDataModelService: coreDataService, dataService: dataService)
        let favouriteScreen = FavouriteViewController(presenter: presenter)
        let rightTabBarItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "heart"), tag: 1)
        rightTabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        favouriteScreen.tabBarItem = rightTabBarItem
        return favouriteScreen
    }
    
    static func createDetailedScreen(
        id: String,
        coreDataService: CoreDataModelService,
        dataService: IDataService,
        isfromFavourite: Bool
    ) -> UIViewController {
        let presenter = DetailScreenPresenter(id: id, coreDataService: coreDataService, dataService: dataService, isFromFavourite: isfromFavourite)
        let detailedScreen = DetailScreenViewController(presenter: presenter)
        return detailedScreen
    }
    static func createAlertController(with error: Error) -> UIAlertController {
        let alertConroller = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        let alerAction = UIAlertAction(title: "Отмена", style: .destructive)
        alertConroller.addAction(alerAction)
        return alertConroller
    }
}

