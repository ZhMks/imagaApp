import UIKit

final class FavouriteViewController: UIViewController {
    // MARK: - properties
    private let presenter: IFavouriteScreenPresenter
    
    private let favouriteTableView: UITableView = {
        let item = UITableView()
        item.rowHeight = UITableView.automaticDimension
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    // MARK: - lifecycle
    init(presenter: IFavouriteScreenPresenter) {
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
        setupTableView()
        view.backgroundColor = Asset.backgroundColor.color
    }
}
// MARK: - view output
extension FavouriteViewController: IFavouriteScreenView {
    func showDetailScreen(_ controller: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func updateData() {
        DispatchQueue.main.async {
            self.favouriteTableView.reloadData()
        }
    }
}
// MARK: - tableView datasource
extension FavouriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.returnNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableCell.identifier, for: indexPath) as? FavouriteTableCell else { return UITableViewCell() }
        cell.backgroundColor = .green
        let dataForCell = presenter.returnModelList()[indexPath.row]
        cell.updateCell(model: dataForCell)
        return cell
    }
}
// MARK: - tableView delegate
extension FavouriteViewController: UITableViewDelegate {
    
}
// MARK: - layout
private extension FavouriteViewController {
    func addSubviews() {
        view.addSubview(favouriteTableView)
    }
    
    func createConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            favouriteTableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Spacing.standar),
            favouriteTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Spacing.standar),
            favouriteTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Spacing.standar),
            favouriteTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func setupTableView() {
        favouriteTableView.delegate = self
        favouriteTableView.dataSource = self
        favouriteTableView.register(FavouriteTableCell.self, forCellReuseIdentifier: FavouriteTableCell.identifier)
    }
}
