//
//  CustomViewController.swift
//  SwiftStarterApp
//
//  Created by Madeleine Cheng Mei Tee on 18/03/2020.
//  Copyright © 2020 The Techy Hub. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {
    
    // MARK: - Overriding Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This function dismisses the keyboard on tapping anywhere outside the keyboard
        dismissKeyboardOnTapOutside()
        
        // If all your view controllers have a common style, you should set the style here and have all subsequently created view controller implement this class
    }
    
    // MARK: - Private Methods
    private func dismissKeyboardOnTapOutside() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Actions
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
