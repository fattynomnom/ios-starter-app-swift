//
//  RegistrationViewController.swift
//  SwiftStarterApp
//
//  Created by Madeleine Cheng Mei Tee on 18/03/2020.
//  Copyright © 2020 The Techy Hub. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController, AuthServiceDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var dobField: DatePicker!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var tncCheckbox: CustomCheckbox!
    
    private let loadingIndicator = LoadingIndicator()
    
    private var passwordMatches: Bool {
        return passwordField.text == confirmPasswordField.text
    }
    
    // MARK: - Overriding Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting links
        let urlRanges = [
            NSRange(location: 15, length: 18): Websites.TERMS,
            NSRange(location: 38, length: 14): Websites.PRIVACY_POLICY
        ]
        
        tncCheckbox.label.setLink(urlRanges: urlRanges, font: ThemeFont.defaultFont, spacingRequired: false)
    }
    
    // MARK: - Actions
    @IBAction func register(_ sender: Any) {
        if textFieldsValidation([emailField, dobField, passwordField, confirmPasswordField]) {
            if passwordMatches {
                if tncCheckbox.isChecked {
                    sendRequest()
                } else {
                    view.makeToast("Please agree to our Terms & Conditions to continue")
                }
            } else {
                view.makeToast("Passwords do not match")
            }
        }
    }
    
    // MARK: - Private Methods
    private func sendRequest() {
        view.addSubview(loadingIndicator)
        
        let authService = AuthService()
        authService.delegate = self
        
        if let email = emailField.text?.trimmingCharacters(in: .whitespaces), let password = passwordField.text {
            authService.requestRegistration(email: email, password: password)
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
