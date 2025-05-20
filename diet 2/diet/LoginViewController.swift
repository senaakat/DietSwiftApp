import UIKit

class LoginVieWController: UIViewController{
    
    @IBOutlet weak var myButton: UIButton!
    
    @IBAction func loginButtonTapped(_ sender: UIButton){
        performSegue(withIdentifier: "toMain" , sender: self)
        
        myButton.layer.cornerRadius = 50
        myButton.layer.masksToBounds = true
        
    }
}

