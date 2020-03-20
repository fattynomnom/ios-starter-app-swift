//
//  UIViewController.swift
//  SwiftStarterApp
//
//  Created by Madeleine Cheng Mei Tee on 18/03/2020.
//  Copyright © 2020 The Techy Hub. All rights reserved.
//

import UIKit
import Toast_Swift

extension UIViewController {
    
    func textFieldsValidation(_ requiredTextFields: [UITextField]) -> Bool {
        for textField in requiredTextFields {
            guard let textFieldText = textField.text else {
                return false
            }
            
            // Change validation criteria/result here
            if textFieldText.isEmpty {
                view.makeToast("Please fill in all required fields")
                return false
            }
        }
        
        return true
    }
}
