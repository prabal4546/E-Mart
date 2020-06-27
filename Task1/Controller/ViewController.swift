//
//  ViewController.swift
//  Task1
//
//  Created by PRABALJIT WALIA     on 11/05/20.
//  Copyright © 2020 PRABALJIT WALIA    . All rights reserved.
//

import UIKit
import Firebase
import LocalAuthentication

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
 //       authenticateUserAndConfigureView()
        super.viewDidLoad()
        // Animation for Welcome Text
        titleLabel.text = " "
        var charIndex = 0.0
        let titleText = "Welcome"
        for letter in titleText{
            print(0.1*charIndex)
            print(letter)
            Timer.scheduledTimer(withTimeInterval: 0.2*charIndex, repeats: false){ (timer) in
                self.titleLabel.text?.append(letter)
    }
            charIndex += 1


}

}
    
    
//MARK:-
    func authenticateUserAndConfigureView()
    {
        if Auth.auth().currentUser != nil{

            let context:LAContext = LAContext()

            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
            {
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Message") { (True, error) in
                    if True
                    {

                        print("Verified")
                        /* DispatchQueue.main.async {
                         self.navigationController?.isNavigationBarHidden = false

                         self.performSegue(withIdentifier: "mainToTab", sender: nil)
                         }*/
                        DispatchQueue.main.async {
                            let navController = UINavigationController(rootViewController: RegisterViewController())
                            navController.navigationBar.barStyle = .black
                            self.present(navController, animated: true, completion: nil)

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

}
