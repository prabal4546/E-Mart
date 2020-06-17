//
//  ForgotPasswordViewController.swift
//  Task1
//
//  Created by PRABALJIT WALIA     on 15/05/20.
//  Copyright © 2020 PRABALJIT WALIA    . All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func verificationLink(_ sender: UIButton) {
   
        
        func bug()->String?{
            let email = emailTextField.text
            if let email = email  {
                if email.isEmpty{
                    return "Enter your Registered email"
                }
            }
            return nil
        }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    }}
