//
//  UIButtonExtensions.swift
//  Task1
//
//  Created by PRABALJIT WALIA     on 23/06/20.
//  Copyright © 2020 PRABALJIT WALIA    . All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    
    func pulsate(){
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)
        
    }
    //mark
    func setUp(){
        self.addTarget(self, action: #selector(selectionAnimation), for: .touchUpInside)
    }
    
    @objc func selectionAnimation(){
        
        self.center.y -= 20
        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        self.alpha = 0.5
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.center.y += 20
            self.transform = CGAffineTransform.identity
            self.alpha = 1
            
        }, completion: nil)
    }
    

    
}

extension UIView {
    func rotate360Degrees() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = 1
        rotateAnimation.repeatCount=Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
 
}

extension UIViewController {
     
     func hideKeyboardWhenTappedAround() {
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
         tap.cancelsTouchesInView = false
         view.addGestureRecognizer(tap)
     }
     @objc func dismissKeyboard() {
         view.endEditing(true)
     }
     
 }

