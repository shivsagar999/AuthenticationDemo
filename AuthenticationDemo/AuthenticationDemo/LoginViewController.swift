//
//  ViewController.swift
//  AuthenticationDemo
//
//  Created by Shivsagar S Wagle on 05/05/23.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        emailTextField.layer.cornerRadius = 20
//        emailTextField.layer.borderWidth = 1.0
//        emailTextField.layer.borderColor = UIColor.gray.cgColor
//
//        passwordTextField.layer.cornerRadius = 20
//        passwordTextField.layer.borderWidth = 1.0
//        passwordTextField.layer.borderColor = UIColor.gray.cgColor
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
    }
    
}

