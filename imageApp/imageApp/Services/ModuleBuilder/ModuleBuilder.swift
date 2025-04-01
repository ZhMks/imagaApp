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
        let leftTabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "checkmark"), tag: 0)
        mainScreen.tabBarItem = leftTabBarItem
        return mainScreen
    }
    
    static func createFavouriteScreen() -> UIViewController {
        let coreDataModelService = CoreDataModelService()
        let presenter = FavouritePresenter(coreDataModelService: coreDataModelService)
        let favouriteScreen = FavouriteViewController(presenter: presenter)
        let rightTabBarItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "xmark"), tag: 1)
        favouriteScreen.tabBarItem = rightTabBarItem
        return favouriteScreen
    }
    
    static func createDetailedScreen(model: DetailScreenModel) -> UIViewController {
        let presenter = DetailScreenPresenter(model: model)
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

