//
//  ForgotPasswordViewController.swift
//  AuthenticationDemo
//
//  Created by Shivsagar S Wagle on 10/05/23.
//

import UIKit
import FirebaseAuth


class ForgotPasswordViewController: UIViewController {

    
    
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func submitPressed(_ sender: UIButton) {
        
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text ?? "") {error in
            if let error = error {
              // An error happened.
              print("Error sending password reset email: \(error.localizedDescription)")
            } else {
              // Password reset email sent successfully.
              print("Password reset email sent successfully.")
            }
        }
        
    }
}
