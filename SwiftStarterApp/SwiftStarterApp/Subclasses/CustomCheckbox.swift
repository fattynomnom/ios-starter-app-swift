//
//  CustomCheckbox.swift
//  SwiftStarterApp
//
//  Created by Madeleine Cheng Mei Tee on 18/03/2020.
//  Copyright © 2020 The Techy Hub. All rights reserved.
//

import UIKit
import SimpleCheckbox

@IBDesignable class CustomCheckbox: UIView {
    
    // MARK: - Properties
    private let checkbox = Checkbox()
    let label = UITextView()
    
    @IBInspectable var text: String = "" {
        didSet {
            label.text = text
        }
    }
    
    var isChecked: Bool {
        return checkbox.isChecked
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    // MARK: - Private Methods
    private func initView() {
        // This line removes the fixed height attribute set in the storyboard to silence layout errors
        constraints.first { $0.firstAttribute == NSLayoutConstraint.Attribute.height }?.isActive = false
        
        initCheckbox()
        initLabel()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(changeValue))
        isUserInteractionEnabled = true
        addGestureRecognizer(gesture)
    }
    
    private func initCheckbox() {
        // Change checkbox look & behaviour here (doc: https://github.com/BeauNouvelle/SimpleCheckbox)
        checkbox.borderStyle = .square
        checkbox.checkmarkStyle = .tick
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        addSubview(checkbox)
        
        // Constraints
        checkbox.widthAnchor.constraint(equalToConstant: 25).isActive = true
        checkbox.heightAnchor.constraint(equalTo: checkbox.widthAnchor).isActive = true
        checkbox.topAnchor.constraint(equalTo: topAnchor).isActive = true
        checkbox.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
    
    private func initLabel() {
        // Change label look & behaviour here
        label.font = ThemeFont.defaultFont
        label.isEditable = false
        label.isSelectable = false
        label.isScrollEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        // Constraints
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    // MARK: - Actions
    @objc func changeValue() {
        checkbox.isChecked = !checkbox.isChecked
    }
}
