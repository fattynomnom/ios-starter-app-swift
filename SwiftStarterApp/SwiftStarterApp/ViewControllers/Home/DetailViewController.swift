//
//  DetailViewController.swift
//  SwiftStarterApp
//
//  Created by Madeleine Cheng Mei Tee on 20/03/2020.
//  Copyright © 2020 The Techy Hub. All rights reserved.
//

import UIKit

class DetailViewController: CustomViewController {

    // MARK: - Properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailTextView: UITextView!
    
    var user: User?
    
    // MARK: - Overriding Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let imgUrl = user?.imgUrl else {
            return
        }
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: imgUrl))
        nameLabel.text = user?.name
        emailTextView.text = user?.email
    }
}
