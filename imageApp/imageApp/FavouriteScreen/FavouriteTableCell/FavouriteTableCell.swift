import UIKit
import Kingfisher
protocol IFavouriteCell: AnyObject {
    func favouriteButtonDidTap(_ model: FavouriteModel)
}

final class FavouriteTableCell: UITableViewCell {
    // MARK: - properties
    static let identifier = "FavouriteTableCell"
    weak var delegate: IFavouriteCell?
    private var model: FavouriteModel?
    
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
    
    private let favouriteButton: UIButton = {
        let item = UIButton(type: .system)
        item.translatesAutoresizingMaskIntoConstraints = false
        let backgroundImage = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
        item.tintColor = Asset.accentColor.color
        item.setBackgroundImage(backgroundImage, for: .normal)
        return item
    }()
    // MARK: - lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubviews()
        createConstraints()
        addTargetToButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(model: FavouriteModel) {
        self.model = model
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
// MARK: - private func
private extension FavouriteTableCell {
    @objc func favouriteButtonTapped() {
        guard let model = model else { return }
        delegate?.favouriteButtonDidTap(model)
    }
    
    func addTargetToButton() {
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
    }
}
// MARK: - layout
private extension FavouriteTableCell {
    
    func addSubviews() {
        contentView.addSubview(favouriteImageView)
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(favouriteButton)
    }
    
    func createConstraints() {
        let safeArea = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate(
            createConstraintsForImageView(safeArea) +
            createConstraintsForNameLabel(safeArea) +
            createConstraintsForFavouriteButton(safeArea)
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
            authorNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: favouriteButton.leadingAnchor),
            authorNameLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ]
    }
    
    func createConstraintsForFavouriteButton(_ safeArea: UILayoutGuide) -> [NSLayoutConstraint] {
        [
            favouriteButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Spacing.standar),
            favouriteButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Spacing.standar),
            favouriteButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -Spacing.standar)
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
