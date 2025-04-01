import UIKit

protocol IFavouriteScreenPresenter: AnyObject {}
protocol IFavouriteScreenView: AnyObject {}

final class FavouritePresenter: IFavouriteScreenPresenter {
    weak var view: IFavouriteScreenView?
}

