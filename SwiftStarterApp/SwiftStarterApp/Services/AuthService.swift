//
//  AuthService.swift
//  SwiftStarterApp
//
//  Created by Madeleine Cheng Mei Tee on 19/03/2020.
//  Copyright © 2020 The Techy Hub. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol AuthServiceDelegate {
    func onSuccess()
    func onFailure(_ error: String)
}

class AuthService: NetworkingService {
    
    // MARK: - Properties
    var delegate: AuthServiceDelegate?
    
    // MARK: - Public Methods
    public func requestLogin(email: String, password: String) {
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]

        AF.request(API.LOGIN, method: .post, parameters: parameters, headers: headers).validate().response {
            response in
            switch response.result {
            case .success:
                print("Successful login request")

                if let json = response.data {
                    do{
                        let data = try JSON(data: json)
                        self.parseLoginData(data: data, email: email)
                    }
                    catch{
                        print("JSON error")
                    }
                }

            case .failure:
                print("Login request failed")

                if let error = self.parseErrorResponse(response.data) {
                    self.delegate?.onFailure(error)
                }
            }
        }
    }
    
    public func requestRegistration(email: String, password: String) {
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        
        AF.request(API.LOGIN, method: .post, parameters: parameters, headers: headers).validate().response {
            response in
            switch response.result {
            case .success:
                print("Successful registration request")
                
                if let json = response.data {
                    do{
                        let data = try JSON(data: json)
                        self.parseLoginData(data: data, email: email)
                    }
                    catch{
                        print("JSON error")
                    }
                }
                
            case .failure:
                print("Registration request failed")
                
                if let error = self.parseErrorResponse(response.data) {
                    self.delegate?.onFailure(error)
                }
            }
        }
    }
    
    // MARK: - Private Methods
    private func parseLoginData(data: JSON, email: String) {
        let accessToken = data["token"].stringValue
        
        // Storing the access token in the keychain (encrypted)
        keychain.set(accessToken, forKey: KeychainKey.ACCESS_TOKEN_KEY)

        // Storing the user's email in user defaults (unencrypted)
        defaults.set(email, forKey: UserDefaultsKey.EMAIL_KEY)
        
        // Calling the delegate
        delegate?.onSuccess()
    }
}
