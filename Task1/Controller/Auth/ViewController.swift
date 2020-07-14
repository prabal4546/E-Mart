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
    
    var context = LAContext()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK:-
    override func viewDidLoad() {
 //       authenticateUserAndConfigureView()
        super.viewDidLoad()
        context.localizedCancelTitle = "End Session"
        context.localizedFallbackTitle = "Use Passcode"
        context.localizedReason = "App needs user authentication"
        evaluatePolicy()
        imageView.alpha = 0

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
    override func viewDidAppear(_ animated: Bool) {
        animateImage()
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
    
    func animateImage(){
        UIView.animate(withDuration: 1.5, delay: 0.75, options: [.transitionCurlUp], animations: {
            self.imageView.alpha = 1
            self.imageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (completed) in
            
        }
    }
    //MARK:- Biometric
    func evaluatePolicy(){
        
        var errorCanEval:NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &errorCanEval){
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Fallback Title- override reason") { (success, error) in
                print(success)
                if let err = error{
                    let evalErrorCode = LAError(_nsError: err as NSError)
                    switch evalErrorCode.code{
                    case LAError.Code.userCancel:
                        print("user cacelled")
                    case LAError.Code.userFallback:
                        print("fallback")
                    default:
                        print("other error")
                    }
                }
            }
            
        }else{
            print("can't evaluate")
            print(errorCanEval?.localizedDescription ?? "no error desc")
        }
    }

}
