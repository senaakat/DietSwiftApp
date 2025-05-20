

import UIKit

class GoalViewController: UIViewController {


    var currentMealGoals: [String: Int] = [:]
       
       // Hedefler ayarlandığında geri bildirim
       var onGoalsSet: (([String: Int]) -> Void)?

       // Her öğün için ayrı ayrı textField bağlantıları
       @IBOutlet weak var breakfastTextField: UITextField!
       @IBOutlet weak var lunchTextField: UITextField!
       @IBOutlet weak var dinnerTextField: UITextField!
       @IBOutlet weak var snackTextField: UITextField!
       @IBOutlet weak var totalGoalLabel: UILabel!
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           [breakfastTextField, lunchTextField, dinnerTextField, snackTextField].forEach {
                       $0?.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
                   }
           
           // Mevcut hedefleri alanlara yerleştir
           breakfastTextField.text = "\(currentMealGoals["Kahvaltı"] ?? 0)"
           lunchTextField.text = "\(currentMealGoals["Öğle"] ?? 0)"
           dinnerTextField.text = "\(currentMealGoals["Akşam"] ?? 0)"
           snackTextField.text = "\(currentMealGoals["Ara Öğün"] ?? 0)"
           
           updateTotalGoalLabel()
       }
       
       @IBAction func saveButtonTapped(_ sender: UIButton) {
           // Girilen verileri integer'a çevir
           guard let breakfast = Int(breakfastTextField.text ?? ""),
                 let lunch = Int(lunchTextField.text ?? ""),
                 let dinner = Int(dinnerTextField.text ?? ""),
                 let snack = Int(snackTextField.text ?? "") else {
               return
           }
           
           // Hedefleri sözlüğe aktar
           let newGoals: [String: Int] = [
               "Kahvaltı": breakfast,
               "Öğle": lunch,
               "Akşam": dinner,
               "Ara Öğün": snack
           ]
           
           // Closure ile geri gönder
           onGoalsSet?(newGoals)
           dismiss(animated: true)
       }

       @IBAction func cancelButtonTapped(_ sender: UIButton) {
           dismiss(animated: true)
       }
    
    @objc func textFieldDidChange() {
        updateTotalGoalLabel()
    }

    func updateTotalGoalLabel() {
        let breakfast = Int(breakfastTextField.text ?? "") ?? 0
        let lunch = Int(lunchTextField.text ?? "") ?? 0
        let dinner = Int(dinnerTextField.text ?? "") ?? 0
        let snack = Int(snackTextField.text ?? "") ?? 0

        let total = breakfast + lunch + dinner + snack
        totalGoalLabel.text = "Hedef: \(total) kcal"
    }
}
