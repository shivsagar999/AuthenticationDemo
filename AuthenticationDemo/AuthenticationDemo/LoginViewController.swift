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
import GoogleSignIn

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailVerificationLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var googleSignIn: GIDSignInButton!
    
    var ref: DatabaseReference!
    var auth: Auth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
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
    
    
    
    
    @IBAction func loginWithGoogle(_ sender: UIButton) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
            return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) {[weak self] result, error in

                guard let self = self else { return }
                  self.activityIndicator.isHidden = true
                  if error != nil {
                      self.errorLabel.isHidden = false
                      return
                  }
                  
                  guard let authResult = result else {
                      self.errorLabel.isHidden = false
                      return
                  }
                  
                  if !authResult.user.isEmailVerified {
                        self.emailVerificationLabel.isHidden = false
                        return
                    }
                  var email = authResult.user.email
                  
                
                  self.ref.child("users").child(authResult.user.uid).setValue(["email": email])
                  UserData.shared.userUID = authResult.user.uid
                  let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserInfoViewController") as! UserInfoViewController
                  DispatchQueue.main.async {
                      self.present(vc, animated: true)
                  }
              
            }
          
        }
    }
    
}

