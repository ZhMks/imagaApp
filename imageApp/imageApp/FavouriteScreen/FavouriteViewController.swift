import UIKit

final class FavouriteViewController: UIViewController {
    // MARK: - properties
    private let favouriteTableView: UITableView = {
        let item = UITableView()
        item.rowHeight = UITableView.automaticDimension
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        createConstraints()
        setupTableView()
        view.backgroundColor = .red
    }
}
// MARK: - tableView datasource
extension FavouriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
            favouriteTableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16.0),
            favouriteTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16.0),
            favouriteTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16.0),
            favouriteTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    func setupTableView() {
        favouriteTableView.delegate = self
        favouriteTableView.dataSource = self
        favouriteTableView.register(FavouriteTableCell.self, forCellReuseIdentifier: FavouriteTableCell.identifier)
    }
}
