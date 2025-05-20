import UIKit

class FoodSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    var items: [FoodItem] = []
    var filteredItems: [FoodItem] = []
    var mealType: String = ""
    weak var delegate: FoodSelectionDelegate?
    
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = mealType // Başlık için seçilen öğün
        
        setupTableView()
        setupSearchController()
        filteredItems = items
        
        // Scroll sorunlarını önler
        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = true
        tableView.bounces = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Yiyecek ara..."
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = filteredItems[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "\(item.calories) kcal"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = filteredItems[indexPath.row]
        let selectedFood = FoodItem(
            name: selected.name,
            mealType: selected.mealType,
            calories: selected.calories,
            carbs: selected.carbs,
            protein: selected.protein,
            fat: selected.fat,
            date: Date()
        )
        delegate?.didSelectFood(item: selectedFood)
        dismiss(animated: true)
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.isEmpty else {
            filteredItems = items
            tableView.reloadData()
            return
        }
        
        let lowercasedQuery = query.lowercased()
        
        filteredItems = items.filter {
            $0.name.lowercased().contains(lowercasedQuery) ||
            "\($0.calories)".contains(lowercasedQuery) ||
            "\($0.carbs)".contains(lowercasedQuery) ||
            "\($0.protein)".contains(lowercasedQuery) ||
            "\($0.fat)".contains(lowercasedQuery)
        }
        
        tableView.reloadData()
    }
}
