import UIKit
import UserNotifications

protocol FoodSelectionDelegate: AnyObject {
    func didSelectFood(item: FoodItem)
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dailyCalorieGoal: Int = 0

    var mealGoals: [String: Int] = [:]
    
    @IBOutlet weak var totalCaloriesLabel : UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalGoalMainLabel: UILabel!
    @IBOutlet weak var totalCarbsLabel: UILabel!
    @IBOutlet weak var totalProteinLabel: UILabel!
    @IBOutlet weak var totalFatLabel: UILabel!


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGoal", let goalVC = segue.destination as? GoalViewController {
            goalVC.onGoalsSet = { [weak self] updatedGoals in
                let total = updatedGoals.values.reduce(0, +)
                self?.totalGoalMainLabel.text = "Hedef: \(total) kcal"
            }
        }
    }
    
    @IBAction func showHistoryTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController {
            vc.foodHistory = foodHistory
            if let nav = navigationController {
                        nav.pushViewController(vc, animated: true)
                    } else {
                        let navVC = UINavigationController(rootViewController: vc)
                        navVC.modalPresentationStyle = .fullScreen
                        present(navVC, animated: true)
                    }
        }
    }

    
    var foodHistory: [FoodItem] = []
    
    let mealTypes = ["Kahvaltı", "Öğle", "Akşam", "Ara Öğün"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        loadHistory()
        loadCalorieGoal()
        updateTotalCaloriesLabel()
        
    }
    
// 🔄 YENİ: TableView'da kaç section var
    func numberOfSections(in tableView: UITableView) -> Int {
        return mealTypes.count
    }

    // 🔄 YENİ: Her öğün için kaç satır gösterilecek
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let meal = mealTypes[section]
        return todaysMeals(for: meal).count
    }

    // 🔄 YENİ: Section başlıkları (Kahvaltı, Öğle, vb.)
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mealTypes[section]
    }

    // 🔄 GÜNCELLENDİ: Satırları bugünkü ve ilgili öğüne göre göster
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meal = mealTypes[indexPath.section]
        let items = todaysMeals(for: meal)
        let food = items[indexPath.row]

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell" )
        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        cell.textLabel?.text = food.name
        cell.detailTextLabel?.text = "\(formatter.string(from: food.date)) - \(food.calories) kcal"
        
        if indexPath.row == 0 {
                let totalForMeal = items.reduce(0) { $0 + $1.calories }
                if let maxAllowed = mealGoals[meal], totalForMeal > maxAllowed {
                    cell.detailTextLabel?.textColor = .red
                    cell.detailTextLabel?.text! += " ⚠️ Hedef Aşıldı!"
                    
                    sendOverLimitNotification(for: meal)
                }
            }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let meal = mealTypes[indexPath.section]
            let items = todaysMeals(for: meal)
            let itemToDelete = items[indexPath.row]
            
            // foodHistory'den ilgili item'ı kaldır
            if let index = foodHistory.firstIndex(where: { $0.id == itemToDelete.id }) {
                foodHistory.remove(at: index)
            }
            
            // Güncellemeleri kaydet
            saveHistory()
            updateTotalCaloriesLabel()
            tableView.reloadData()
        }
    }
    
    @IBAction func mealButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "FoodSelectionViewController") as? FoodSelectionViewController {
            vc.delegate = self

            switch sender.tag {
            case 0:
                vc.items = FoodDatabase.kahvaltiItems
                vc.mealType = "Kahvaltı"
            case 1:
                vc.items = FoodDatabase.ogleItems
                vc.mealType = "Öğle"
            case 2:
                vc.items = FoodDatabase.aksamItems
                vc.mealType = "Akşam"
            case 3:
                vc.items = FoodDatabase.araOgunItems
                vc.mealType = "Ara Öğün"
            default:
                return
            }

            let navVC = UINavigationController(rootViewController: vc)
            present(navVC, animated: true)
        }
    }
    

    
    @IBAction func addGoalTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let vc = storyboard.instantiateViewController(withIdentifier: "GoalViewController") as? GoalViewController {
               vc.modalPresentationStyle = .formSheet
               vc.currentMealGoals = self.mealGoals

               vc.onGoalsSet = { newGoals in
                   self.mealGoals = newGoals
                   self.dailyCalorieGoal = newGoals.values.reduce(0, +)
                   self.saveCalorieGoal()
                   self.tableView.reloadData()
                   self.updateTotalCaloriesLabel()
                   self.totalGoalMainLabel.text = "Hedef: \(self.dailyCalorieGoal) kcal"
               }
               

               present(vc, animated: true)
           }
    }

    
    func todaysMeals(for mealType: String) -> [FoodItem] {
            return foodHistory.filter {
                $0.mealType == mealType &&
                Calendar.current.isDateInToday($0.date)
            }
        }

        
    func updateTotalCaloriesLabel() {
        let todayItems = foodHistory.filter { Calendar.current.isDateInToday($0.date) }

            let totalCalories = todayItems.reduce(0) { $0 + $1.calories }
            let totalCarbs = todayItems.reduce(0.0) { $0 + $1.carbs }
            let totalProtein = todayItems.reduce(0.0) { $0 + $1.protein }
            let totalFat = todayItems.reduce(0.0) { $0 + $1.fat }

            totalCaloriesLabel.text = "\(totalCalories) kcal"
            totalCarbsLabel.text = "K: \(Int(totalCarbs)) g"
            totalProteinLabel.text = "P: \(Int(totalProtein)) g"
            totalFatLabel.text = "Y: \(Int(totalFat)) g"
    }
    
    func saveHistory() {
        if let data = try? JSONEncoder().encode(foodHistory) {
            UserDefaults.standard.set(data, forKey: "foodHistory")
        }
    }

    func loadHistory() {
        if let data = UserDefaults.standard.data(forKey: "foodHistory"),
           let savedItems = try? JSONDecoder().decode([FoodItem].self, from: data) {
            foodHistory = savedItems
        }
    }
    
    func saveCalorieGoal() {
        UserDefaults.standard.set(dailyCalorieGoal, forKey: "dailyCalorieGoal")
            if let encoded = try? JSONEncoder().encode(mealGoals) {
                UserDefaults.standard.set(encoded, forKey: "mealGoals")
            }
    }

    func loadCalorieGoal() {
        if let savedGoal = UserDefaults.standard.value(forKey: "dailyCalorieGoal") as? Int {
                dailyCalorieGoal = savedGoal
            }
            if let data = UserDefaults.standard.data(forKey: "mealGoals"),
               let savedMealGoals = try? JSONDecoder().decode([String: Int].self, from: data) {
                mealGoals = savedMealGoals
            } else {
                mealGoals = [
                            "Kahvaltı": 0,
                            "Öğle": 0,
                            "Akşam": 0,
                            "Ara Öğün": 0
                        ]
            }
    }
    
    func sendOverLimitNotification(for meal: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // 🔁 gecikmeli gönder
            let content = UNMutableNotificationContent()
            content.title = "⚠️ Kalori Limiti Aşıldı"
            content.body = "\(meal) öğünündeki kalori hedefini geçtin!"
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
    }

    
    }

    // 🔄 GÜNCELLENDİ: Seçilen yemek bugünkü öğüne ekleniyor
    extension MainViewController: FoodSelectionDelegate {
        func didSelectFood(item: FoodItem) {
            foodHistory.append(item)
            tableView.reloadData()
            updateTotalCaloriesLabel()
            saveHistory()
        }
    }

