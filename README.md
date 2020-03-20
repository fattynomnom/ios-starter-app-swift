# ios-starter-app-swift
A starter Swift app containing basic functionalities for any app to get started. Open the project via **SwiftStarterApp.xcworkspace** (do not use SwiftStarterApp.xcodeproj). Please remember to change your app name, app bundle indentifier and signing capabilities via Project > General Settings.

## Install Cocoapods
Cocoapods is a dependency manager. Click [here](https://guides.cocoapods.org/using/getting-started.html#getting-started) and follow instructions to install Cocoapods locally.

## Setting up CocoaPods-Keys
Cocoapods-keys is a plugin that makes it easy to have per-user config settings stored securely in the developer's keychain, and not in the application source. Click [here](https://github.com/orta/cocoapods-keys) for installation instructions and guides. This plugin will be used to store sensitive variables such as API keys, client IDs and client secrets.

This starter app already has the ClientId and ClientSecret keys defined. To add new keys or delete the existing keys, edit the Podfile then run 'pod install' in the terminal. To change the existing key values, run:

```
pod keys set "key" "value"
```

## Making network requests
To make any requests without an authorization token attached, see the examples in this file: /Services/LoginService.swift
For any requests that requires an access token to be attached and a subsequent request call to refresh the token (if it is revoked), use:

```
session.request(...).validate().response...
```

instead of 'AF.request(...).validate().response...'. This 'session' session manager uses a predefined interceptor class called RetryPolicy to perform the authorization token attaching and refreshes the token if request fails. Please modify the RetryPolicy class according to your project's client API structure.

<!-- ###### Rule of thumb:
- If you find yourself writing the same code over and over, consider subclassing or making it an extension -->