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
        return tabBar
    }
    
    static func createMainScreen() -> UIViewController {
        let presenter = MainScreenPresenter()
        let mainScreen = MainScreenViewController(presenter: presenter)
        let leftTabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "checkmark"), tag: 0)
        mainScreen.tabBarItem = leftTabBarItem
        return mainScreen
    }
    
    static func createFavouriteScreen() -> UIViewController {
        let presenter = FavouritePresenter()
        let favouriteScreen = FavouriteViewController(presenter: presenter)
        let rightTabBarItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "xmark"), tag: 1)
        favouriteScreen.tabBarItem = rightTabBarItem
        return favouriteScreen
    }
    
    static func createDetailedScreen() -> UIViewController {
        let presenter = DetailScreenPresenter()
        let detailedScreen = DetailScreenViewController(presenter: presenter)
        return detailedScreen
    }
}

