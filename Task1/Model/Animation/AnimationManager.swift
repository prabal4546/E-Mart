//
//  AnimationManager.swift
//  Task1
//
//  Created by PRABALJIT WALIA     on 05/07/20.
//  Copyright © 2020 PRABALJIT WALIA    . All rights reserved.
//

import UIKit
class AnimationManager {
    
    // Calculated screen bounds
    class var screenBounds: CGRect {
        return UIScreen.main.bounds
    }
    
    // Screen positions
    class var screenRight: CGPoint {
        return CGPoint(x: screenBounds.maxX, y: screenBounds.midY)
    }
    
    class var screenTop: CGPoint {
        return CGPoint(x: screenBounds.midX, y: screenBounds.minY)
    }
    
    class var screenLeft: CGPoint {
        return CGPoint(x: screenBounds.minX, y: screenBounds.midY)
    }
    
    class var screenBottom: CGPoint {
        return CGPoint(x: screenBounds.midX, y: screenBounds.maxY)
    }
    
    
    
}

