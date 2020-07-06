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
        hideKeyboardWhenTappedAround()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        authenticateUserConfiguration()
        
        loginButtonLabel.layer.cornerRadius = 30
        loginButtonLabel.layer.borderWidth = 1
        loginButtonLabel.layer.borderColor = UIColor.clear.cgColor
        
        emailTextField.layer.cornerRadius = 50
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.clear.cgColor
        
        passwordTextField.layer.cornerRadius = 50
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.clear.cgColor
        
        
    }
    let db = Firestore.firestore()
    //MARK:-Forgot Password
    @IBAction func forgotPassword(_ sender: UIButton) {
        
        let forgotPasswordAlert = UIAlertController(title: "Forgot password?", message: "Enter resgistered email address", preferredStyle: .alert)
        forgotPasswordAlert.addTextField { (textField) in
            textField.placeholder = "Enter your email"
        }
        forgotPasswordAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        forgotPasswordAlert.addAction(UIAlertAction(title: "Reset Password", style: .default, handler: { (action) in
            let resetEmail = forgotPasswordAlert.textFields?.first?.text
            Auth.auth().sendPasswordReset(withEmail: resetEmail!, completion: { (error) in
                if error != nil{
                    let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetFailedAlert, animated: true, completion: nil)
                }else {
                    let resetEmailSentAlert = UIAlertController(title: "Reset password email sent successfully", message: "Check your primary inbox or spam folder", preferredStyle: .alert)
                    resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetEmailSentAlert, animated: true, completion: nil)
                }
            })
        }))
        self.present(forgotPasswordAlert, animated: true, completion: nil)
        //  self.performSegue(withIdentifier: "LoginToFP", sender: self)
        
        
    }
    
    //MARK:-OUTLETS
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var loginPageTitle: UILabel!
    @IBOutlet weak var loginButtonLabel: UIButton!
    @IBAction func loginPressed(_ sender: UIButton) {
        
        sender.setUp()
        sender.selectionAnimation()
        
        if let email = emailTextField.text , let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if error != nil{
                    print(error)
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    self.performSegue(withIdentifier: "LoginToChat", sender: nil)
                    self.clear()
                }
            }
        }
        
    }
    
    //MARK:-
    @IBAction func touchID(_ sender: UIButton) {
        
        sender.pulsate()
        
        let context:LAContext = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "You can Use biometric authentication",reply: {(wasSuccessfull,error) in
                if wasSuccessfull{
                    print("Correct")
                    
                    //     self.performSegue(withIdentifier: "LoginToChat", sender: self)
                    let alert = UIAlertController(title: "Success", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    print("incorrect")
                }
            })
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    func clear() {
        self.emailTextField.text?.removeAll()
        self.passwordTextField.text?.removeAll()
    }
    
    //MARK:- Session Status
    
    func authenticateUserConfiguration()
    {
        if Auth.auth().currentUser != nil{
            let context:LAContext = LAContext()
            
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
            {
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Message") { (True, error) in
                    if True
                    {
                        
                        print("Sucess")
                        DispatchQueue.main.async {
                            self.navigationController?.isNavigationBarHidden = false
                            
                            self.performSegue(withIdentifier: "LoginToChat", sender: nil)
                            
                        }
                        
                    }
                    else
                    {
                        print(error)
                    }
                }
            }else{
                print("Wait")
            }
        }
        
        
    }
    
    
    
    
    
    //MARK:-View Lifecycle
       override func viewWillAppear(_ animated: Bool) {
           loginPageTitle.alpha = 0
           loginButtonLabel.isHidden = true
           
       }
       
       override func viewDidAppear(_ animated: Bool) {
            animateTitleInWithSpring()
           showLogInButton()
          }
       
       func animateTitleInWithSpring(){
           UIView.animate(withDuration: 2.0, delay: 0.25, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: [], animations: {
               self.loginPageTitle.alpha = 1
               self.loginPageTitle.frame.origin.y += 50
           }, completion: nil)
       }
       
       func showLogInButton(){
           UIView.transition(with: self.loginButtonLabel, duration: 1.0, options: [.transitionFlipFromTop], animations: {
               self.loginButtonLabel.isHidden = false
           }, completion: nil)
       }
    
    
    
    
    
    
    
    
}








