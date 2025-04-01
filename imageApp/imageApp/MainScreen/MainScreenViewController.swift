import UIKit

class MainScreenViewController: UIViewController {
    // MARK: - properties
    private let searchField = SearchField()
    private let presenter: IMainScreePresenter
    
    private let mainScreenCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let item = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    // MARK: - lifecycle
    init(presenter: IMainScreePresenter) {
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
        setupCollectionView()
        view.backgroundColor = .yellow
    }
}
// MARK: - collectionView DataSource
extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionCell.identifier, for: indexPath) as? MainCollectionCell else { return UICollectionViewCell() }
        cell.backgroundColor = .black
        return cell
    }
}
// MARK: - collectionView Delegate
extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    
}
// MARK: - scrollView delegate
extension MainScreenViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let height = mainScreenCollectionView.contentSize.height - 100-scrollView.frame.size.height
        if position > height {
        }
    }
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
            searchField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Spacing.standar),
            searchField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            searchField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Spacing.standar),
            searchField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Spacing.standar)
        ]
    }
    func createConstraintsForMainCollectionView(_ safeArea: UILayoutGuide) -> [NSLayoutConstraint] {
        [
            mainScreenCollectionView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: Spacing.standar),
            mainScreenCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mainScreenCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mainScreenCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
    }
}
