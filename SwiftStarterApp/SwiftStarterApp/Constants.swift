//
//  Constants.swift
//  SwiftStarterApp
//
//  Created by Madeleine Cheng Mei Tee on 18/03/2020.
//  Copyright © 2020 The Techy Hub. All rights reserved.
//

import Foundation
import Alamofire
import KeychainSwift
import Keys

let defaults = UserDefaults.standard
let keychain = KeychainSwift()
let keys = SwiftStarterAppKeys()

// Modify these headers based on your API requirements
var headers: HTTPHeaders = [
    "password-client-id": keys.passwordClientId,
    "password-client-secret": keys.passwordClientSecret,
    "client-id": keys.clientId,
    "client-secret": keys.clientSecret
]

struct KeychainKey {
    static let ACCESS_TOKEN_KEY = "ACCESS_TOKEN_KEY"
    static let REFRESH_TOKEN_KEY = "REFRESH_TOKEN_KEY"
}

struct UserDefaultsKey {
    static let EMAIL_KEY = "EMAIL_KEY"
}

struct API {
    static let BASE_URL = "https://reqres.in/api/"
    static let LOGIN = BASE_URL + "login"
    static let REGISTRATION = BASE_URL + "register"
    static let TEST_DATA = BASE_URL + "users"
    static let TOKEN_REFRESH = "https://emcq-api.tth.asia/oauth/token"
}

struct Websites {
    static let BASE_URL = "https://theroyalpress.my/"
    static let TERMS = BASE_URL + "terms-and-conditions"
    static let PRIVACY_POLICY = BASE_URL + "privacy-policy"
}

struct ThemeFont {
    static let defaultFont = UIFont.systemFont(ofSize: 14)
}

struct StoryboardIdentifier {
    static let HOME_NAVIGATION = "HomeNavigationController"
    static let LOGIN_NAVIGATION = "LoginNavigationController"
}

struct CellIdentifier {
    static let USER_CELL = "UserCell"
}

struct SegueIdentifier {
    static let USER_DETAIL_SEGUE = "DetailSegue"
}

struct Sizing {
    static let userCellWidth = UIScreen.main.bounds.width * 0.85
    static let userCellMargin = UIScreen.main.bounds.width * 0.075
}
