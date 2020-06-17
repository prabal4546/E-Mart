//
//  ProfileViewController.swift
//  Task1
//
//  Created by PRABALJIT WALIA     on 12/05/20.
//  Copyright © 2020 PRABALJIT WALIA    . All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
          super.viewDidLoad()
        
    }

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var name: UITextField!
    
    @IBAction func updatePressed(_ sender: Any) {
//        let user = Auth.auth().currentUser
//        if let user = user {
//
//          let uid = user.uid
//          let email = user.email
//          let photoURL = user.photoURL
//          var multiFactorString = "MultiFactor: "
//          for info in user.multiFactor.enrolledFactors {
//            multiFactorString += info.displayName ?? "[DispayName]"
//            multiFactorString += " "
//          }
//          // ...
            do {
                  try Auth.auth().signOut()
                    
                    navigationController?.popToRootViewController(animated: true)
                    
                } catch let signOutError as NSError {
                  print ("Error signing out: %@", signOutError)
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


