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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        createConstraintsForImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(model: MainResponseModel) {
      
    }
    
}
private extension MainCollectionCell {
    func addSubviews() {
        contentView.addSubview(photoImageView)
    }
    func createConstraintsForImageView() {
        let safeArea = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 120),
            photoImageView.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
}

