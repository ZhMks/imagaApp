import UIKit

protocol IMainScreePresenter: AnyObject {
    
}

protocol IMainScreenView: AnyObject {
    
}

final class MainScreenPresenter: IMainScreePresenter {
    weak var view: IMainScreenView?
}
