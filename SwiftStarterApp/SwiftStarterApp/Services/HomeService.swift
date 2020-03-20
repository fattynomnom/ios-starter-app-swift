//
//  HomeService.swift
//  SwiftStarterApp
//
//  Created by Madeleine Cheng Mei Tee on 19/03/2020.
//  Copyright © 2020 The Techy Hub. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol HomeServiceDelegate {
    func didGetData(_ users: [User]?)
}

class HomeService: NetworkingService {
    
    // MARK: - Properties
    private var pageNumber = 1
    private var totalPages = 0
    var delegate: HomeServiceDelegate?
    
    var nextPageExist: Bool {
        return pageNumber <= totalPages
    }
    
    // MARK: - Public Methods
    func requestData() {
        let parameters: Parameters = [
            "page": pageNumber
        ]
        
        session.request(API.TEST_DATA, method: .get, parameters: parameters, headers: headers).validate().response {
            response in
            switch response.result {
            case .success:
                print("Successful data request")

                if let json = response.data {
                    do{
                        let data = try JSON(data: json)
                        self.parseJsonData(data: data)
                    }
                    catch{
                        print("JSON error")
                    }
                }

            case .failure:
                print("Data request failed")
                self.delegate?.didGetData(nil)
            }
        }
    }
    
    // MARK: - Private Methods
    private func parseJsonData(data: JSON) {
        // Getting total pages
        if pageNumber == 1 {
            totalPages = data["total_pages"].intValue
        }
        
        // Parsing data
        let dataArray = data["data"].arrayValue
        var users: [User] = []
        
        for item in dataArray {
            let firstName = item["first_name"].stringValue
            let email = item["email"].stringValue
            let imgUrl = item["avatar"].stringValue
            
            let user = User(name: firstName, email: email, imgUrl: imgUrl)
            users.append(user)
        }
        
        // Sending back data to the view controller
        delegate?.didGetData(users)
        
        // Incrementing the page number
        pageNumber += 1
    }
}
