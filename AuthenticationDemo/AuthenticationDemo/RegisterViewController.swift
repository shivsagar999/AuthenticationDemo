//
//  RegisterViewController.swift
//  AuthenticationDemo
//
//  Created by Shivsagar S Wagle on 06/05/23.
//

import UIKit
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth


class RegisterViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var ref: DatabaseReference!
    var auth: Auth!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        //ref = Database.database(url: "http://127.0.0.1:9000/?ns=autheticationdemo-78169").reference()
        auth = Auth.auth()
        //local emulator connection
        //auth.useEmulator(withHost: "localhost", port: 9099)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        activityIndicator.isHidden = false
        self.errorLabel.isHidden = true
        var email = emailTextField.text ?? ""
        auth.createUser(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { authResult, error in
            
            self.activityIndicator.isHidden = true
            
            if error != nil {
                self.errorLabel.isHidden = false
                return
            }
            guard let authResult = authResult else {
                self.errorLabel.isHidden = false
                return
            }
            
            UserData.shared.userUID = authResult.user.uid
            self.ref.child("users").child(authResult.user.uid).setValue(["email": email])
            authResult.user.sendEmailVerification { rror in
                if error != nil {
                    self.errorLabel.isHidden = false
                    return
                } else {
                    _ = self.navigationController?.popViewController(animated: true)
                }
                
            }
        }
    }
    

}
