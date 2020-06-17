//
//  LogInViewController.swift
//  Task1
//
//  Created by PRABALJIT WALIA     on 11/05/20.
//  Copyright © 2020 PRABALJIT WALIA    . All rights reserved.
//

import UIKit
import Firebase
import LocalAuthentication
import GoogleSignIn

class LogInViewController: UIViewController,UITextFieldDelegate {
    
    
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //GIDSignIn.sharedInstance()?.presentingViewController = self
        //GIDSignIn.sharedInstance().delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    
    
    
    
   
    
    
    @IBAction func forgotPassword(_ sender: UIButton) {
        self.performSegue(withIdentifier: "LoginToFP", sender: self)
    }
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginPressed(_ sender: Any) {
//=========================================================================================================================
        if let email = emailTextField.text , let password = passwordTextField.text{
               Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e)
                }else{
                    self.performSegue(withIdentifier: "LoginToChat", sender: self)
                }
               }
            }
            
        }
    
    @IBAction func touchID(_ sender: UIButton) {
        let context:LAContext = LAContext()
               if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
                   context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "You can Use biometric authentication",reply: {(wasSuccessfull,error) in
                       if wasSuccessfull{
                           print("Correct")
                           self.performSegue(withIdentifier: "LoginToChat", sender: self)
                       }else{
                           print("incorrect")
                       }
               })
               
               }
           }
    
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        
        //hide keyboard by return key
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            emailTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
            return true
        }
    }
    
    
    
    
    


  


