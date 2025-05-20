import UIKit

struct DaySection {
    let date: Date
    let mealsByType: [String: [FoodItem]] // e.g. "Kahvaltı": [Yumurta, Simit]
}

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var foodHistory: [FoodItem] = []
    private var groupedByDate: [DaySection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Yemek Günlüğüm"
        view.backgroundColor = UIColor(red: 255/255, green: 211/255, blue: 209/255, alpha: 1.0)
        tableView.backgroundColor = UIColor(red: 255/255, green: 211/255, blue: 209/255, alpha: 1.0)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        groupDataByDate()

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Geri",
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
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
        let sortedMealTypes = Array(daySection.mealsByType.keys.sorted())
        let mealType = sortedMealTypes[indexPath.row]
        let items = daySection.mealsByType[mealType] ?? []

        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(red: 1.0, green: 0.93, blue: 0.95, alpha: 1.0)

        let titleLabel = UILabel()
        titleLabel.text = mealType
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = UIColor.darkGray

        let itemLabels = items.map { item -> UILabel in
            let label = UILabel()
            label.numberOfLines = 2
            label.textAlignment = .left
            label.font = .systemFont(ofSize: 13)
            label.textColor = .black
            label.text = "\(item.name) (\(item.calories) kcal) - KH: \(Int(item.carbs))g • P: \(Int(item.protein))g • Y: \(Int(item.fat))g"
            return label
        }

        let verticalStack = UIStackView(arrangedSubviews: [titleLabel] + itemLabels)
        verticalStack.axis = .vertical
        verticalStack.spacing = 8
        verticalStack.translatesAutoresizingMaskIntoConstraints = false

        cell.contentView.addSubview(verticalStack)
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10),
            verticalStack.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -10),
            verticalStack.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            verticalStack.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16)
        ])

        return cell
    }

    @objc func backButtonTapped() {
        if let presentingVC = presentingViewController {
            dismiss(animated: true, completion: nil)
        } else if let nav = navigationController {
            nav.popViewController(animated: true)
        } else {
            if let window = UIApplication.shared.windows.first {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let rootVC = storyboard.instantiateViewController(withIdentifier: "MainViewController")
                window.rootViewController = UINavigationController(rootViewController: rootVC)
                window.makeKeyAndVisible()
            }
        }
    }
}
