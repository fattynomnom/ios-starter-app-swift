//
//  LoadingIndicator.swift
//  SwiftStarterApp
//
//  Created by Madeleine Cheng Mei Tee on 20/03/2020.
//  Copyright © 2020 The Techy Hub. All rights reserved.
//

import UIKit

class LoadingIndicator: UIView {
    
    // MARK: - Properties
    private let activityIndicator = UIActivityIndicatorView()
    private let size = CGFloat(100)
    
    // MARK: - Initialization
    init() {
        super.init(frame: .null)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    // MARK: - Overriding Methods
    override func didMoveToSuperview() {
        activityIndicator.startAnimating()
        
        guard let superview = superview else {
            return
        }
        
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
    }
    
    // MARK: - Private Methods
    private func initView() {
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
        
        heightAnchor.constraint(equalToConstant: size).isActive = true
        widthAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        initActivityIndicator()
    }
    
    private func initActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
