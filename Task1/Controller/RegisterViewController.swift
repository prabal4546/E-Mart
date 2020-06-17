//
//  RegisterViewController.swift
//  Task1
//
//  Created by PRABALJIT WALIA     on 11/05/20.
//  Copyright © 2020 PRABALJIT WALIA    . All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class RegisterViewController: UIViewController,GIDSignInDelegate {
    override func viewDidLoad() {
            super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        

            // Do any additional setup after loading the view.
        }
 

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
  func errorCheck() -> String? {
      let email = emailTextField.text
      let password = passwordTextField.text
      if let email = email , let password = password {
          if email.isEmpty || password.isEmpty {
               return "Please Fill in all the fields"     
          }
      }else{
          return "Please Fill in all the fields"
      }
      return nil
  }
    
    @IBAction func registerPressed(_ sender: Any) {
        
        
        if let email = emailTextField.text , let password = passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
              if let e = error
              {
                print(e.localizedDescription)
                
              }else{
                //Naigate to NextViewController
                self.performSegue(withIdentifier: "RegisterToChat", sender: self)
                    }
                }
            }
            
        }
   

    
    @IBAction func googlePressed(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            if let error = error {
            print(error.localizedDescription)
            return
            }
            guard let auth = user.authentication else { return }
            let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
            Auth.auth().signIn(with: credentials) { (authResult, error) in
            if let error = error {
            print(error.localizedDescription)
            } else {
            print("Login Successful")
            self.performSegue(withIdentifier: "RegisterToChat", sender: self)
            //This is where you should add the functionality of successful login
            //i.e. dismissing this view or push the home view controller etc
                }
        }
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
