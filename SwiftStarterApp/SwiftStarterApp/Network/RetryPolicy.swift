//
//  RetryPolicy.swift
//  SwiftStarterApp
//
//  Created by Madeleine Cheng Mei Tee on 19/03/2020.
//  Copyright © 2020 The Techy Hub. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RetryPolicy: RequestInterceptor {
    
    let accessToken = keychain.get(KeychainKey.ACCESS_TOKEN_KEY)
    let retryLimit = 1
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard let accessToken = accessToken else {
            return
        }
        
        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization(bearerToken: accessToken))
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // Note: status code returned from API for an invalidated access token should always be unique to not confuse the interceptor with other error types
        if request.retryCount < retryLimit && request.response?.statusCode == 500 {
            refreshToken { (success) in
                completion(.retry)
            }
        } else {
            completion(.doNotRetry)
        }
    }
    
    func refreshToken(_ refreshResult: @escaping (Bool) -> Void) {
        print("Refreshing token")
        
        guard let refreshToken = keychain.get(KeychainKey.REFRESH_TOKEN_KEY) else {
            return
        }
        
        let parameters: Parameters = [
            "refresh_token": refreshToken,
            "grant_type": "refresh_token",
            "client_id": keys.passwordClientId,
            "client_secret": keys.passwordClientSecret,
            "scope": ""
        ]
        
        AF.request(API.TOKEN_REFRESH, method: .post, parameters: parameters, headers: headers).validate().response {
            response in
            switch response.result {
            case .success:
                print("Successfully refreshed token")
                
                if let json = response.data {
                    do{
                        let data = try JSON(data: json)
                        let accessToken = data["access_token"].stringValue
                        keychain.set(accessToken, forKey: KeychainKey.ACCESS_TOKEN_KEY)
                    }
                    catch{
                        print("JSON error")
                    }
                }
                
                refreshResult(true)
                
            case .failure:
                print("Refresh token failure")
                refreshResult(false)
            }
        }
    }
}
