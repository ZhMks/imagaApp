import UIKit

protocol IDetailScreenPresenter: AnyObject {
    
}

protocol IDetailScreenView: AnyObject {
    
}

final class DetailScreenPresenter: IDetailScreenPresenter {
    weak var view: IDetailScreenView?
}
