//
//  Biometric.swift
//  Task1
//
//  Created by PRABALJIT WALIA     on 24/06/20.
//  Copyright © 2020 PRABALJIT WALIA    . All rights reserved.
//

import UIKit
import LocalAuthentication


class BiometricAuth {
    
    public static let shared = BiometricAuth()
    private let context = LAContext()
    private let reason = "Your Request Message"
    private var error: NSError?
    
    
    public func Authenticate(completion: @escaping (Bool,NSError?)->()){
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
                if let error = error {
                    print(error.localizedDescription)
                    completion(false,error as NSError)
                } else {
                    completion(true,nil)
                }
            }
        } else {
            completion(false,nil)
        }
    }
    
    enum BiometricType: String {
        case none
        case touchID
        case faceID
    }
    
    var biometricType: BiometricType {
        guard self.context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return .none
        }
        if #available(iOS 11.0, *) {
            switch context.biometryType {
            case .none:
                return .none
            case .touchID:
                return .touchID
            case .faceID:
                return .faceID
            }
        } else {
            return self.context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) ? .touchID : .none
        }
    }
    
    //MARK:- Bioemtric type
    var biometricTypeString : String {
        return biometricType.rawValue
    }
}

