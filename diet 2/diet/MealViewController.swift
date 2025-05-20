import UIKit

class MealViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var mealType: String = "Öğün"
    var foodList: [String] = ["Yulaf","Muz"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = mealType
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem){
        print ("Ekleme ekranına geçiş yapılacak")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ??
                   UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = foodList[indexPath.row]
        return cell
    }

}
