import UIKit

final class ModuleBuilder {
    static func createMainTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        let mainScreen = MainScreenViewController()
        let favouriteScreen = FavouriteViewController()
        
        let leftTabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "checkmark"), tag: 0)
        let rightTabBarItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "xmark"), tag: 1)
        
        mainScreen.tabBarItem = leftTabBarItem
        favouriteScreen.tabBarItem = rightTabBarItem
        
        let mainNavigationController = UINavigationController(rootViewController: mainScreen)
        let favouriteNavigationController = UINavigationController(rootViewController: favouriteScreen)
        tabBar.viewControllers = [mainNavigationController, favouriteNavigationController]
        tabBar.selectedIndex = 0
        return tabBar
    }
}

