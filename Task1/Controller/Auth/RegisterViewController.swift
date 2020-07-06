//
//  RegisterViewController.swift
//  Task1
//
//  Created by PRABALJIT WALIA     on 11/05/20.
//  Copyright © 2020 PRABALJIT WALIA    . All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FirebaseStorage

class RegisterViewController: UIViewController,GIDSignInDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        // setUpElements()
        hideKeyboardWhenTappedAround()
        let tapGesture = UITapGestureRecognizer()
               tapGesture.addTarget(self, action: #selector(RegisterViewController.openGalley(tapgesture:)))
               profileImage.isUserInteractionEnabled = true
               profileImage.addGestureRecognizer(tapGesture)
        
        //outlet tweaks
        signUpButton.layer.cornerRadius = 15
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.clear.cgColor
        
        emailTextField.layer.cornerRadius = 15
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.clear.cgColor
        
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.clear.cgColor
        
        googleButton.layer.cornerRadius = 30
        googleButton.layer.borderWidth = 1
        googleButton.layer.borderColor = UIColor.clear.cgColor
        
        
        
    
        
    }
    
    //MARK:-Outlets
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var signUpPageLabel: UILabel!
    
    @IBOutlet weak var googleButton: UIButton!
    
    //MARK:-
    func setUpElements(){
        //
        errorLabel.alpha = 0
        //
        //        Utilities.styleTextField(emailTextField)
        //        Utilities.styleTextField(passwordTextField)
        //        Utilities.styleFilledButton(signUpButton)
    }
    func clear() {
        self.emailTextField.text?.removeAll()
        self.passwordTextField.text?.removeAll()
    }
    //MARK:-Error Check
    func validateFields()->String? {
        
        if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields."
        }
        
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in:
            .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            
            
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    //
    //  func errorCheck() -> String? {
    //      let email = emailTextField.text
    //      let password = passwordTextField.text
    //      if let email = email , let password = password {
    //          if email.isEmpty || password.isEmpty {
    //               return "Please Fill in all the fields"
    //          }
    //      }else{
    //          return "Please Fill in all the fields"
    //      }
    //      return nil
    //  }
    
    //MARK:- New User
    @IBAction func registerPressed(_ sender: UIButton) {
        
        sender.setUp()
        sender.selectionAnimation()
      
        let error = validateFields()
        
        if error != nil {
            
            showError(error!)
            
            
        }
        else{
            
            
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) {(result, err) in
                
                //Check for errors
                if err != nil {
                    self.showError("Error creating user")
                }
                else{
                    // User created successfully
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["email":email, "password": password, "uid": result!.user.uid]) { (error) in
                        if error != nil{
                            self.showError("Error saving user data")
                        }
                            //transition trial
                        
                    }
                    
                    // Transition to the home screen
                    self.performSegue(withIdentifier: "RegisterToChat", sender: self)
                    
                }
                
            }
            
            
        }
        
    }
    func showError(_ message: String){
        
        errorLabel.text = message
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        
        errorLabel.alpha = 1
    }
    
    //MARK:-Google Sign In
    @IBAction func googlePressed(_ sender: UIButton) {
        
        sender.setUp()
        sender.selectionAnimation()
        
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
    //MARK:-Image Picker Functionality
    let db = Firestore.firestore()
    var ref = DatabaseReference.self
    let imagePicker = UIImagePickerController()
    
    @objc func openGalley(tapgesture: UITapGestureRecognizer){
         
           self.setupImagePicker()
       }
    
   
    
    
    
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{

func setupImagePicker(){
    
    if(UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)){
        
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.isEditing = true
        imagePicker.delegate = self
     
         self.present(imagePicker, animated: true, completion: nil)
    }
}

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
    profileImage.image = image
    self.dismiss(animated: true, completion: nil)
}
    
    
    //MARK:-View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        signUpPageLabel.alpha = 0
        signUpButton.isHidden = true
        googleButton.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
           animateTitleInWithSpring()
        showSignUpButton()
       }
    
    func animateTitleInWithSpring(){
        UIView.animate(withDuration: 2.0, delay: 0.25, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: [], animations: {
            self.signUpPageLabel.alpha = 1
            self.signUpPageLabel.frame.origin.y += 50
        }, completion: nil)
    }
    
    func showSignUpButton(){
        UIView.transition(with: self.signUpButton, duration: 1.0, options: [.transitionFlipFromTop], animations: {
            self.signUpButton.isHidden = false
            self.googleButton.isHidden = false
        }, completion: nil)
    }

    

}
