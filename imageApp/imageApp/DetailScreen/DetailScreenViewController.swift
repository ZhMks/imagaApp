import UIKit

final class DetailScreenViewController: UIViewController {
    // MARK: - properties
    private let presenter: IDetailScreenPresenter
    
    private let photoImageView: UIImageView = {
        let item = UIImageView()
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    private let authorLabel: UILabel = {
        let item = UILabel()
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    private let dateLabel: UILabel = {
        let item = UILabel()
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    private let numberOfDownloadsLabel: UILabel = {
        let item = UILabel()
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    private let addressLabel: UILabel = {
        let item = UILabel()
        item.translatesAutoresizingMaskIntoConstraints = false
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
    }
}
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
        let heightAspect = photoImageView.widthAnchor.constraint(equalTo: photoImageView.heightAnchor, multiplier: 1)
        return [
            photoImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            photoImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            heightAspect,
            photoImageView.widthAnchor.constraint(equalToConstant: 200)
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
