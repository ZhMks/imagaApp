import UIKit

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
        return item
    }()
    // MARK: - lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(model: MainResponseModel) {
        
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
        [
            favouriteImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            favouriteImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            favouriteImageView.trailingAnchor.constraint(lessThanOrEqualTo: authorNameLabel.leadingAnchor),
            favouriteImageView.heightAnchor.constraint(equalToConstant: 40),
            favouriteImageView.widthAnchor.constraint(equalToConstant: 40),
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
