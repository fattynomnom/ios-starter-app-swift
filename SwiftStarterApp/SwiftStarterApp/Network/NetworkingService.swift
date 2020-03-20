//
//  NetworkingService.swift
//  SwiftStarterApp
//
//  Created by Madeleine Cheng Mei Tee on 19/03/2020.
//  Copyright © 2020 The Techy Hub. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let session = Session(configuration: .default, interceptor: RetryPolicy())

class NetworkingService {
    
    // MARK: - Public Methods
    func parseErrorResponse(_ response: Data?) -> String? {
        if let json = response {
            do{
                let data = try JSON(data: json)
                
                // Ensure that all API requests supplies a universal JSON key for error messages to use this function
                let error = data["error"].stringValue
                print("Request error: \(error)")
                
                return error
            }
            catch{
                print("JSON error")
            }
        }
        
        return nil
    }
}
