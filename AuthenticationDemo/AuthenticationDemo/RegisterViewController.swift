//
//  RegisterViewController.swift
//  AuthenticationDemo
//
//  Created by Shivsagar S Wagle on 06/05/23.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        self.errorLabel.isHidden = true
        Auth.auth().createUser(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { authResult, error in
            
            if error != nil {
                self.errorLabel.isHidden = false
                return
            }
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserInfoViewController") as! UserInfoViewController
            DispatchQueue.main.async {
                self.present(vc, animated: true)
            }
        }
    }
    

}
