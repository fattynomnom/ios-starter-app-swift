//
//  UITextView.swift
//  SwiftStarterApp
//
//  Created by Madeleine Cheng Mei Tee on 19/03/2020.
//  Copyright © 2020 The Techy Hub. All rights reserved.
//

import UIKit

extension UITextView {
    
    func setLink(urlRanges: [NSRange : String], font: UIFont, spacingRequired: Bool) {
        guard let text = text else {
            return
        }
        
        // Setting the font for the whole string
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.setAttributes([.font: font], range: NSRange(location: 0, length: text.count))

        // Setting how links should appear
        linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
        ]

        // Setting the link
        for urlRange in urlRanges {
            let url = URL(string: urlRange.value)!
            attributedString.addAttribute(.link, value: url, range: urlRange.key)
            attributedString.addAttribute(.font, value: font, range: urlRange.key)
        }

        // Increase paragraph and character spacing if needed
        if spacingRequired {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 3

            attributedString.addAttributes([
                .kern: 0,
                .paragraphStyle: style
            ], range: NSRange(location: 0, length: text.count))
        }

        attributedText = attributedString
        isUserInteractionEnabled = true
        isSelectable = true
    }
}
