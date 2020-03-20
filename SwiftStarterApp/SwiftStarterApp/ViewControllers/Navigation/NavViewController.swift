//
//  NavViewController.swift
//  SwiftStarterApp
//
//  Created by Madeleine Cheng Mei Tee on 20/03/2020.
//  Copyright © 2020 The Techy Hub. All rights reserved.
//

import UIKit

class NavViewController: UINavigationController {

    // MARK: - Overriding Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        navigationItem.setRightBarButton(logoutButton, animated: false)
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    // MARK: - Actions
    @objc func logout() {
        // To do: create & call the logout API via a service class then remove all user defaults & keychain values
        defaults.removeObject(forKey: UserDefaultsKey.EMAIL_KEY)
        keychain.delete(KeychainKey.ACCESS_TOKEN_KEY)
        keychain.delete(KeychainKey.REFRESH_TOKEN_KEY)
        
        // Redirecting back to login
        let loginNavController = self.storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.LOGIN_NAVIGATION)
        view.window?.rootViewController = loginNavController
    }
}
