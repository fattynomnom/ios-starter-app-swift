//
//  UIApplication.swift
//  SwiftStarterApp
//
//  Created by Madeleine Cheng Mei Tee on 20/03/2020.
//  Copyright © 2020 The Techy Hub. All rights reserved.
//

import UIKit

extension UIApplication {
    
    // This function tries to open the first url passed in the array
    // If it fails, it tries to open the second url
    // Usage in code: UIApplication.tryURL(urls: ["instagram://user?username=theroyalpress", "https://www.instagram.com/theroyalpress/"])
    // The first url opens the Instagram app
    // If the app does not exist, it opens the Instagram web URL in safari
    class func tryURL(urls: [String]) {
        let application = UIApplication.shared
        
        for url in urls {
            if application.canOpenURL(URL(string: url)!) {
                if #available(iOS 10.0, *) {
                    application.open(URL(string: url)!, options: [:], completionHandler: nil)
                }
                else {
                    application.openURL(URL(string: url)!)
                }
                return
            }
        }
    }
}
