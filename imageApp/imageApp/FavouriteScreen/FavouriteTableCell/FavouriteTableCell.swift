import UIKit
import Kingfisher

final class FavouriteTableCell: UITableViewCell {
    // MARK: - properties
    static let identifier = "FavouriteTableCell"
    
    private let favouriteImageView: UIImageView = {
        let item = UIImageView()
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    private let authorNameLabel: UILabel = {
        let item = UILabel()
        item.translatesAutoresizingMaskIntoConstraints = false
        item.textColor = Asset.textColor.color
        return item
    }()
    // MARK: - lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(model: FavouriteModel) {
        guard let stringFromModel = model.url else { return }
        let url = URL(string: stringFromModel)
        favouriteImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "xmark")) { [weak self] result in
            switch result {
            case .success(let retrivedImage):
                DispatchQueue.main.async {
                    self?.favouriteImageView.image = retrivedImage.image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
// MARK: - layout
private extension FavouriteTableCell {
    
    func addSubviews() {
        contentView.addSubview(favouriteImageView)
        contentView.addSubview(authorNameLabel)
    }
    
    func createConstraints() {
        let safeArea = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate(
            createConstraintsForImageView(safeArea) +
            createConstraintsForNameLabel(safeArea)
        )
    }
    
    func createConstraintsForImageView(_ safeArea: UILayoutGuide) -> [NSLayoutConstraint] {
        let heightAspect: CGFloat = (Constants.imageWidth / (UIScreen.main.bounds.width - Spacing.standar))
        return [
            favouriteImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            favouriteImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            favouriteImageView.trailingAnchor.constraint(lessThanOrEqualTo: authorNameLabel.leadingAnchor),
            favouriteImageView.heightAnchor.constraint(equalTo: favouriteImageView.widthAnchor, multiplier: heightAspect),
            favouriteImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            favouriteImageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ]
    }
    
    func createConstraintsForNameLabel(_ safeArea: UILayoutGuide) -> [NSLayoutConstraint] {
        [
            authorNameLabel.centerYAnchor.constraint(equalTo: favouriteImageView.centerYAnchor),
            authorNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor),
            authorNameLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ]
    }
}
// MARK: - constants
private extension FavouriteTableCell {
    enum Constants {
        static let imageHeight: CGFloat = 40.0
        static let imageWidth: CGFloat = 40.0
    }
}
