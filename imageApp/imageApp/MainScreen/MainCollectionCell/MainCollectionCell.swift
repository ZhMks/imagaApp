import UIKit
import Kingfisher

final class MainCollectionCell: UICollectionViewCell {
    // MARK: - properties
    static let identifier = "MainCollectionCell"
    
    private let photoImageView: UIImageView = {
        let item = UIImageView()
        item.translatesAutoresizingMaskIntoConstraints = false
        item.layer.cornerRadius = 10.0
        item.clipsToBounds = true
        return item
    }()
    
    // MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        createConstraintsForImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(model: MainScreenModel) {
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
private extension MainCollectionCell {
    func addSubviews() {
        contentView.addSubview(photoImageView)
    }
    
    func createConstraintsForImageView() {
        let safeArea = contentView.safeAreaLayoutGuide
        let heightAspect: CGFloat = (Constants.imageWidth / (UIScreen.main.bounds.width - Spacing.standar))
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor, multiplier: heightAspect),
            photoImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth)
        ])
    }
}
// MARK: - constants
private extension MainCollectionCell {
    enum Constants {
        static let imageHeight: CGFloat = 120
        static let imageWidth: CGFloat = 120
    }
}
