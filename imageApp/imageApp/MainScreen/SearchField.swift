import UIKit
protocol ISearchField: AnyObject {
    func cancelButtonTapped()
}

final class SearchField: UITextField {
    // MARK: - properties
    weak var searchFieldDelegate: ISearchField?
  
    private let searchButton: UIButton = {
        let item = UIButton(type: .system)
        item.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate)
        item.setBackgroundImage(image, for: .normal)
        item.tintColor = .systemGray
        return item
    }()
    private let placeHolder: UILabel = {
        let item = UILabel()
        item.translatesAutoresizingMaskIntoConstraints = false
        item.textColor = .systemGray
        item.text = "Search"
        item.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        return item
    }()
    private let cancleButton: UIButton = {
        let item = UIButton(type: .system)
        item.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "x.circle.fill")?.withRenderingMode(.alwaysTemplate)
        item.setBackgroundImage(image, for: .normal)
        item.tintColor = .systemGray
        item.isHidden = true
        return item
    }()
    // MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addConstraints()
        layer.cornerRadius = Constants.cornerRadius
        backgroundColor = .black
        textColor = .systemGray
        cancleButton.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - funcs
    func updateViews() {
        guard let text = text else { return }
        if isEditing {
            searchButton.isHidden = true
            placeHolder.isHidden = true
            cancleButton.isHidden = false
        } else {
            if text.isEmpty {
                searchButton.isHidden = false
                placeHolder.isHidden = false
                cancleButton.isHidden = true
            } else {
                searchButton.isHidden = true
                placeHolder.isHidden = true
                cancleButton.isHidden = false
            }
        }
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRectInset(
            CGRect(
                x: 0,
                y: 0,
                width: bounds.width - Constants.spacing * 3,
                height: bounds.height
            ),
            Constants.spacing,0
        )
    }
}
// MARK: - private funcs
private extension SearchField {
    
    @objc func cancelButtonDidTap() {
        if text != nil {
            text = nil
        }
        searchFieldDelegate?.cancelButtonTapped()
    }
    
    func addSubviews() {
        addSubview(searchButton)
        addSubview(placeHolder)
        addSubview(cancleButton)
    }
    
    func addConstraints() {
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate(
            createConstraintsForSearchButton(safeArea) +
            createConstraintsForPlaceHolder(safeArea) +
            createConstraintsForCancelButton(safeArea)
        )
    }
    
    func createConstraintsForSearchButton(_ safeArea: UILayoutGuide) -> [NSLayoutConstraint] {
        [
            searchButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Constants.spacing),
            searchButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constants.spacing),
            searchButton.trailingAnchor.constraint(lessThanOrEqualTo: placeHolder.leadingAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: Constants.height),
            searchButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -Constants.spacing)
        ]
    }
    
    func createConstraintsForPlaceHolder(_ safeArea: UILayoutGuide) -> [NSLayoutConstraint] {
        [
            placeHolder.centerYAnchor.constraint(equalTo: searchButton.centerYAnchor),
            placeHolder.leadingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: Constants.spacing),
            placeHolder.trailingAnchor.constraint(lessThanOrEqualTo: cancleButton.leadingAnchor),
            placeHolder.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -Constants.spacing)
        ]
    }
    
    func createConstraintsForCancelButton(_ safeArea: UILayoutGuide) -> [NSLayoutConstraint] {
        [
            cancleButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Constants.spacing),
            cancleButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Constants.spacing),
            cancleButton.heightAnchor.constraint(equalToConstant: Constants.height),
            cancleButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -Constants.spacing)
        ]
    }
}
// MARK: - constants
private extension SearchField {
    enum Constants {
        static let cornerRadius: CGFloat = 10.0
        static let spacing: CGFloat = 7.0
        static let height: CGFloat = 22.0
    }
}
