import UIKit

final class ModuleBuilder {
    static func createMainTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        let mainScreen = createMainScreen()
        let favouriteScreen = createFavouriteScreen()
        let mainNavigationController = UINavigationController(rootViewController: mainScreen)
        let favouriteNavigationController = UINavigationController(rootViewController: favouriteScreen)
        tabBar.viewControllers = [mainNavigationController, favouriteNavigationController]
        tabBar.selectedIndex = 0
        tabBar.tabBar.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.1)
        return tabBar
    }
    
    static func createMainScreen() -> UIViewController {
        let networkService = NetworkService()
        let decoderService = DecoderService()
        let dataService = DataService(networkService: networkService, decoderService: decoderService)
        let presenter = MainScreenPresenter(dataService: dataService)
        let mainScreen = MainScreenViewController(presenter: presenter)
        let leftTabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "photo"), tag: 0)
        leftTabBarItem.selectedImage = UIImage(systemName: "photo.fill")
        mainScreen.tabBarItem = leftTabBarItem
        return mainScreen
    }
    
    static func createFavouriteScreen() -> UIViewController {
        let coreDataModelService = CoreDataModelService()
        let presenter = FavouritePresenter(coreDataModelService: coreDataModelService)
        let favouriteScreen = FavouriteViewController(presenter: presenter)
        let rightTabBarItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "heart"), tag: 1)
        rightTabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        favouriteScreen.tabBarItem = rightTabBarItem
        return favouriteScreen
    }
    
    static func createDetailedScreen(model: DetailScreenModel, coreDataService: CoreDataModelService) -> UIViewController {
        let presenter = DetailScreenPresenter(model: model, coreDataService: coreDataService)
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

