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
        item.contentMode = .scaleAspectFill
        item.clipsToBounds = true
        item.layer.cornerRadius = Constants.cornerRadius
        return item
    }()
    
    private let authorNameLabel: UILabel = {
        let item = UILabel()
        item.translatesAutoresizingMaskIntoConstraints = false
        item.textColor = Asset.textColor.color
        item.setContentHuggingPriority(.defaultHigh, for: .horizontal)
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
    
    private let wrapperView: UIView = {
        let item = UIView()
        item.translatesAutoresizingMaskIntoConstraints = false
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
        authorNameLabel.text = "\(model.authorname ?? "") \(model.authorsurname ?? "")"
        if let data = model.image {
            let image = UIImage(data: data)
            favouriteImageView.image = image
        } else {
            favouriteImageView.image = UIImage(systemName: "xmark")
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
        contentView.addSubview(wrapperView)
        wrapperView.addSubview(favouriteImageView)
        wrapperView.addSubview(authorNameLabel)
        wrapperView.addSubview(favouriteButton)
    }
    
    func createConstraints() {
        let safeArea = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate(
            createConstraintsForWrapperView(safeArea) +
            createConstraintsForImageView() +
            createConstraintsForNameLabel() +
            createConstraintsForFavouriteButton()
        )
    }
    
    func createConstraintsForImageView() -> [NSLayoutConstraint] {
         [
            favouriteImageView.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            favouriteImageView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            favouriteImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            favouriteImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            favouriteImageView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor)
        ]
    }
    
    func createConstraintsForNameLabel() -> [NSLayoutConstraint] {
        [
            authorNameLabel.centerYAnchor.constraint(equalTo: favouriteImageView.centerYAnchor),
            authorNameLabel.leadingAnchor.constraint(equalTo: favouriteImageView.trailingAnchor, constant: Spacing.standar),
            authorNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: favouriteButton.leadingAnchor),
            authorNameLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor)
        ]
    }
    
    func createConstraintsForFavouriteButton() -> [NSLayoutConstraint] {
        [
            favouriteButton.centerYAnchor.constraint(equalTo: authorNameLabel.centerYAnchor),
            favouriteButton.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -Spacing.standar),
            favouriteButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            favouriteButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth)
        ]
    }
    
    func createConstraintsForWrapperView(_ safeArea: UILayoutGuide) -> [NSLayoutConstraint] {
        let widthConstraint = wrapperView.widthAnchor
            .constraint(
                equalToConstant: UIScreen.main.bounds.width - Spacing.standar
            )
        widthConstraint.priority = UILayoutPriority(rawValue: 999)
        let heightConstraint = wrapperView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        heightConstraint.priority = UILayoutPriority(rawValue: 999)
        return  [
            wrapperView.topAnchor
                .constraint(
                    equalTo: contentView.topAnchor,
                    constant: Spacing.standar
                ),
            widthConstraint,
            wrapperView.leftAnchor
                .constraint(
                    equalTo: safeArea.leftAnchor
                ),
            wrapperView.rightAnchor
                .constraint(
                    equalTo: safeArea.rightAnchor
                ),
            heightConstraint
        ]
    }
}
// MARK: - constants
private extension FavouriteTableCell {
    enum Constants {
        static let imageWidth: CGFloat = 120.0
        static let imageHeight: CGFloat = 120.0
        static let cornerRadius: CGFloat = 8.0
        static let buttonWidth: CGFloat = 44.0
        static let buttonHeight: CGFloat = 44.0
    }
}
