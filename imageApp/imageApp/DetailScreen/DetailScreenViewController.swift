import UIKit

final class DetailScreenViewController: UIViewController {
    // MARK: - properties
    private let presenter: IDetailScreenPresenter
    
    private let photoImageView: UIImageView = {
        let item = UIImageView()
        item.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "checkmark")
        item.image = image
        return item
    }()
    private let authorLabel: UILabel = {
        let item = UILabel()
        item.translatesAutoresizingMaskIntoConstraints = false
        item.text = "MASS ZHUIN"
        item.textColor = Asset.textColor.color
        item.font = UIFont.boldSystemFont(ofSize: 17)
        return item
    }()
    private let dateLabel: UILabel = {
        let item = UILabel()
        item.translatesAutoresizingMaskIntoConstraints = false
        item.text = "MASS ZHUIN"
        item.textColor = Asset.textColor.color
        item.font = UIFont.systemFont(ofSize: 15)
        return item
    }()
    private let numberOfDownloadsLabel: UILabel = {
        let item = UILabel()
        item.translatesAutoresizingMaskIntoConstraints = false
        item.text = "5"
        item.textColor = Asset.accentColor.color
        item.font = UIFont.systemFont(ofSize: 15)
        return item
    }()
    private let addressLabel: UILabel = {
        let item = UILabel()
        item.translatesAutoresizingMaskIntoConstraints = false
        item.text = "MASS ZHUIN"
        item.textColor = Asset.textColor.color
        item.font = UIFont.systemFont(ofSize: 14)
        return item
    }()
    private let labelsStackView: UIStackView = {
        let item = UIStackView()
        item.translatesAutoresizingMaskIntoConstraints = false
        item.alignment = .leading
        item.axis = .vertical
        item.distribution = .fillProportionally
        item.spacing = 8.0
        return item
    }()
    private let addToFavouriteButton: UIButton = {
        let item = UIButton(type: .system)
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    // MARK: - lifecycle
    init(presenter: IDetailScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        createConstraints()
        view.backgroundColor = .gray
        presenter.viewDidLoad(self)
    }
}
// MARK: - view output
extension DetailScreenViewController: IDetailScreenView {
    func updateData(_ model: DetailScreenModel) {
        let url = URL(string: model.url)
        photoImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "xmark")) { [weak self] result in
            switch result {
            case .success(let retrivedImage):
                DispatchQueue.main.async {
                    self?.photoImageView.image = retrivedImage.image
                }
            case .failure(let kfError):
                print(kfError.localizedDescription)
            }
        }
    }
}
// MARK: - private funcs
private extension DetailScreenViewController {
    @objc func addToFavorites() {
        
    }
    func addTargetToButton() {
        addToFavouriteButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
    }
}
// MARK: - layout
extension DetailScreenViewController {
    func addSubviews() {
        view.addSubview(photoImageView)
        view.addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(authorLabel)
        labelsStackView.addArrangedSubview(dateLabel)
        labelsStackView.addArrangedSubview(numberOfDownloadsLabel)
        labelsStackView.addArrangedSubview(addressLabel)
    }
    
    func createConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate(
            createConstraintsForImageView(safeArea) +
            createConstraintsForLabelsStackView(safeArea)
        )
    }
    
    func createConstraintsForImageView(_ safeArea: UILayoutGuide) -> [NSLayoutConstraint] {
        let heightAspect: CGFloat = (Constants.imageWidth / (UIScreen.main.bounds.width - Spacing.standar))
        return [
            photoImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            photoImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor, multiplier: heightAspect),
            photoImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ]
    }
    
    func createConstraintsForLabelsStackView(_ safeArea: UILayoutGuide) -> [NSLayoutConstraint] {
        [
            labelsStackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: Spacing.standar),
            labelsStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Spacing.standar),
            labelsStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Spacing.standar)
        ]
    }
}
// MARK: - constants
private extension DetailScreenViewController {
    enum Constants {
        static let imageWidth: CGFloat = 400
    }
}
