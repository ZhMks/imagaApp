import UIKit

class MainScreenViewController: UIViewController {
    // MARK: - properties
    private let searchField = SearchField()
    private let presenter: IMainScreePresenter
    
    private let mainScreenCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumInteritemSpacing = Spacing.standar / 4
        let item = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        item.contentInset = UIEdgeInsets(top: Spacing.standar, left: Spacing.standar, bottom: 0, right: Spacing.standar)
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
        view.backgroundColor = Asset.backgroundColor.color
        presenter.viewDidLoad(self)
        presenter.fetchData()
    }
}
// MARK: - collectionView DataSource
extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.returnNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionCell.identifier, for: indexPath) as? MainCollectionCell else { return UICollectionViewCell() }
        cell.backgroundColor = .black
        let dataForCell = presenter.returnImageList()[indexPath.row]
        cell.updateCell(model: dataForCell)
        return cell
    }
}
// MARK: - collectionView Delegate
extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = presenter.returnImageList()[indexPath.row]
        presenter.pushDetailsScreen(model: model)
    }
}
// MARK: - scrollView delegate
extension MainScreenViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let height = mainScreenCollectionView.contentSize.height - 80-scrollView.frame.size.height
        if position > height {
            presenter.fetchMoreImages()
        }
    }
}
// MARK: - textFieldDelegate
extension MainScreenViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchField.updateViews()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchField.updateViews()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchField.updateViews()
        return true
    }
}
extension MainScreenViewController: ISearchField {
    func cancelButtonTapped() {
        searchField.updateViews()
    }
}
// MARK: - view output
extension MainScreenViewController: IMainScreenView {
    func updateData() {
        DispatchQueue.main.async {
            self.mainScreenCollectionView.reloadData()
        }
    }
    func showErrorAlert(_ error: any Error) {
        let alertController = ModuleBuilder.createAlertController(with: error)
        DispatchQueue.main.async {
            self.navigationController?.present(alertController, animated: true)
        }
    }
    
    func showDetailScreen(_ controller: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(controller, animated: true)
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
        searchField.delegate = self
        searchField.searchFieldDelegate = self
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
