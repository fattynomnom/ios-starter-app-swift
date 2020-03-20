//
//  UserCollectionViewCell.swift
//  SwiftStarterApp
//
//  Created by Madeleine Cheng Mei Tee on 20/03/2020.
//  Copyright © 2020 The Techy Hub. All rights reserved.
//

import UIKit
import Kingfisher

class UserCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailText: UITextView!
    
    // MARK: - Overriding Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.kf.indicatorType = .activity
        
        layer.cornerRadius = 15
    }
    
    // MARK: - Public Methods
    func setValues(_ user: User) {
        guard let imgUrl = URL(string: user.imgUrl) else {
            return
        }
        
        imageView.kf.setImage(with: imgUrl)
        nameLabel.text = user.name
        emailText.text = user.email
    }
}
