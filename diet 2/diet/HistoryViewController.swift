import UIKit

struct DaySection {
    let date: Date
    let mealsByType: [String: [FoodItem]] // e.g. "Kahvaltı": [Yumurta, Simit]
}

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var foodHistory: [FoodItem] = []

    private let tableView = UITableView()
    private var groupedByDate: [DaySection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Yemek Günlüğüm"
        view.backgroundColor = .white

        setupTableView()
        groupDataByDate()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Geri", style: .plain, target: self, action: #selector(backButtonTapped))

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
        tableView.separatorStyle = .none
    }

    private func groupDataByDate() {
        let grouped = Dictionary(grouping: foodHistory) {
            Calendar.current.startOfDay(for: $0.date)
        }

        groupedByDate = grouped.map { (date, items) in
            let groupedMeals = Dictionary(grouping: items) { $0.mealType }
            return DaySection(date: date, mealsByType: groupedMeals)
        }.sorted(by: { $0.date > $1.date })
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedByDate.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedByDate[section].mealsByType.keys.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let daySection = groupedByDate[section]
        let total = daySection.mealsByType.values.flatMap { $0 }.reduce(0) { $0 + $1.calories }

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return "\(formatter.string(from: daySection.date)) - Toplam: \(total) kcal"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let daySection = groupedByDate[indexPath.section]
        let mealType = Array(daySection.mealsByType.keys.sorted())[indexPath.row]
        let items = daySection.mealsByType[mealType] ?? []

        let cell = UITableViewCell()
        cell.selectionStyle = .none

        let titleLabel = UILabel()
        titleLabel.text = "\(mealType):"
        titleLabel.font = .boldSystemFont(ofSize: 16)

        let itemLabels = items.map { item -> UILabel in
            let label = UILabel()
            label.text = item.name
            label.font = .systemFont(ofSize: 14)
            label.textAlignment = .center
            label.backgroundColor = UIColor.systemGray5
            label.layer.cornerRadius = 5
            label.layer.masksToBounds = true
            label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            return label
        }

        let totalCalories = items.reduce(0) { $0 + $1.calories }
           let totalCarbs = items.reduce(0) { $0 + $1.carbs }
           let totalProtein = items.reduce(0) { $0 + $1.protein }
           let totalFat = items.reduce(0) { $0 + $1.fat }

           let macroLabel = UILabel()
           macroLabel.font = .systemFont(ofSize: 13)
           macroLabel.textColor = .darkGray
           macroLabel.text = "Toplam: \(totalCalories) kcal | C: \(totalCarbs)g P: \(totalProtein)g F: \(totalFat)g"
        
        let horizontalStack = UIStackView(arrangedSubviews: itemLabels)
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 8
        horizontalStack.distribution = .fillProportionally

        let verticalStack = UIStackView(arrangedSubviews: [titleLabel, horizontalStack])
        verticalStack.axis = .vertical
        verticalStack.spacing = 8
        verticalStack.translatesAutoresizingMaskIntoConstraints = false

        cell.contentView.addSubview(verticalStack)
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            verticalStack.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8),
            verticalStack.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            verticalStack.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16)
        ])

        return cell
    }
    
    @objc func backButtonTapped() {
        if let presentingVC = presentingViewController {
            dismiss(animated: true, completion: nil) // Eğer modal açıldıysa kapat
        } else if let nav = navigationController {
            nav.popViewController(animated: true) // Eğer push ile açıldıysa geri git
        } else {
            // Güvenli fallback: ana ekrana dön
            if let window = UIApplication.shared.windows.first {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let rootVC = storyboard.instantiateViewController(withIdentifier: "MainViewController")
                window.rootViewController = UINavigationController(rootViewController: rootVC)
                window.makeKeyAndVisible()
            }
        }
    }

}
