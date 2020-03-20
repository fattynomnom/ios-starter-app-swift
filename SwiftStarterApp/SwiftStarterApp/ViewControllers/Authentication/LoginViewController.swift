//
//  LoginViewController.swift
//  SwiftStarterApp
//
//  Created by Madeleine Cheng Mei Tee on 18/03/2020.
//  Copyright © 2020 The Techy Hub. All rights reserved.
//

import UIKit

class LoginViewController: CustomViewController, AuthServiceDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let loadingIndicator = LoadingIndicator()
    
    // MARK: - Overriding Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    // MARK: - Actions
    @IBAction func login(_ sender: Any) {
        if textFieldsValidation([emailTextField, passwordTextField]) {
            view.addSubview(loadingIndicator)
            
            let authService = AuthService()
            authService.delegate = self
            
            if let email = emailTextField.text?.trimmingCharacters(in: .whitespaces), let password = passwordTextField.text {
                authService.requestLogin(email: email, password: password)
            }
        }
    }
    
    // MARK: - AuthServiceDelegate
    func onSuccess() {
        let homeNavController = self.storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.HOME_NAVIGATION)
        view.window?.rootViewController = homeNavController
    }
    
    func onFailure(_ error: String) {
        view.makeToast(error)
        loadingIndicator.removeFromSuperview()
    }
}

