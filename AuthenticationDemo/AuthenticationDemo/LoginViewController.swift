//
//  ViewController.swift
//  AuthenticationDemo
//
//  Created by Shivsagar S Wagle on 05/05/23.
//

import UIKit
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailVerificationLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    
    var auth: Auth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        auth = Auth.auth()
        //Local emulator connection
        //auth.useEmulator(withHost: "localhost", port: 9099)
        //self.emailVerificationLabel.isHidden = true
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        activityIndicator.isHidden = false
        self.emailVerificationLabel.isHidden = true
        errorLabel.isHidden = true
        auth.signIn(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { [weak self] authResult, error in
          guard let self = self else { return }
            self.activityIndicator.isHidden = true
            if error != nil {
                self.errorLabel.isHidden = false
                return
            }
            
            guard let authResult = authResult else {
                self.errorLabel.isHidden = false
                return
            }
            
            if !authResult.user.isEmailVerified {
                  self.emailVerificationLabel.isHidden = false
                  return
              }
          
            UserData.shared.userUID = authResult.user.uid
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserInfoViewController") as! UserInfoViewController
            DispatchQueue.main.async {
                self.present(vc, animated: true)
            }
        }
    }
    
}

