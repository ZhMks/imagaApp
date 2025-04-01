import UIKit

class MainScreenViewController: UIViewController {
    // MARK: - properties
    private let searchField = SearchField()
    
    private let mainScreenCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        let item = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        createConstraints()
        setupCollectionView()
        view.backgroundColor = .yellow
    }
}
// MARK: - collectionView DataSource
extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
// MARK: - collectionView Delegate
extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    
}

// MARK: - layout
private extension MainScreenViewController {
    func addSubviews() {
        view.addSubview(searchField)
        view.addSubview(mainScreenCollectionView)
    }
    func setupCollectionView() {
        mainScreenCollectionView.delegate = self
        mainScreenCollectionView.dataSource = self
        mainScreenCollectionView.register(MainCollectionCell.self, forCellWithReuseIdentifier: MainCollectionCell.identifier)
    }
    func createConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        searchField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            createConstraintsForSearchField(safeArea) +
            createConstraintsForMainCollectionView(safeArea)
        )
    }
    func createConstraintsForSearchField(_ safeArea: UILayoutGuide) -> [NSLayoutConstraint] {
        [
            searchField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16.0),
            searchField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            searchField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16.0),
            searchField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16.0)
        ]
    }
    func createConstraintsForMainCollectionView(_ safeArea: UILayoutGuide) -> [NSLayoutConstraint] {
        [
            mainScreenCollectionView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 16.0),
            mainScreenCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mainScreenCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mainScreenCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
    }
}
