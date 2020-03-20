//
//  DatePicker.swift
//  SwiftStarterApp
//
//  Created by Madeleine Cheng Mei Tee on 19/03/2020.
//  Copyright © 2020 The Techy Hub. All rights reserved.
//

import UIKit

class DatePicker: UITextField {
    
    // MARK: - Properties
    private let datePicker = UIDatePicker()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .null)
        initDatePicker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initDatePicker()
    }
    
    // MARK: - Private Methods
    private func initDatePicker() {
        // Formate Date
        datePicker.datePickerMode = .date
        
        // ToolBar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(complete))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        inputAccessoryView = toolbar
        inputView = datePicker
    }
    
    // MARK: - Actions
    @objc func complete(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        text = formatter.string(from: datePicker.date)
        endEditing(true)
    }
    
    @objc func cancel(){
        endEditing(true)
    }
}
