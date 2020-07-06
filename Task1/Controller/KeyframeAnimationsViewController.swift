//
//  KeyframeAnimationsViewController.swift
//  Task1
//
//  Created by PRABALJIT WALIA     on 06/07/20.
//  Copyright © 2020 PRABALJIT WALIA    . All rights reserved.
//

import UIKit

class KeyframeAnimationsViewController: UIViewController {
    
    @IBOutlet weak var animationTarget: UIImageView!
    

     var targetOffset: CGFloat {
            return animationTarget.frame.size.width/2
        }
        
        // MARK: Appearance
        override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
        
        // MARK: View lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            // TODO: Fire keyframe animation
            bounceImageWithKeyframes()
        }

        // MARK: Keyframe animation
        func bounceImageWithKeyframes() {
            let origin = animationTarget.center
            
            UIView.animateKeyframes(withDuration: 4.0, delay: 0, options: [.repeat], animations: {
                
                // Right
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
                    self.animationTarget.center = AnimationManager.screenRight
                    self.animationTarget.center.x -= self.targetOffset
                })
                
                // Top
                UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                    self.animationTarget.center = AnimationManager.screenTop
                    self.animationTarget.center.y += self.targetOffset
                })
                
                // Left
                UIView.addKeyframe(withRelativeStartTime: 0.50, relativeDuration: 0.25, animations: {
                    self.animationTarget.center = AnimationManager.screenLeft
                    self.animationTarget.center.x += self.targetOffset
                })
                
                // Bottom
                UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
                    
                    self.animationTarget.center = origin
                    
    //                self.animationTarget.center = AnimationManager.screenBottom
    //                self.animationTarget.center.y -= self.targetOffset
                })
                
            }, completion: nil)
        }
        
    
    
}
