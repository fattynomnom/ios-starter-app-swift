//
//  MainViewController.swift
//  SwiftStarterApp
//
//  Created by Madeleine Cheng Mei Tee on 18/03/2020.
//  Copyright © 2020 The Techy Hub. All rights reserved.
//

import UIKit

class MainViewController: CustomViewController, HomeServiceDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noItemsLabel: UILabel!
    
    private let homeService = HomeService()
    private let loadingIndicator = LoadingIndicator()
    private var selectedItem: Int?
    
    private var users: [User] = [] {
        didSet {
            noItemsLabel.isHidden = true
            collectionView.reloadData()
        }
    }
    
    // MARK: - Overriding Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(loadingIndicator)
        
        homeService.delegate = self
        homeService.requestData()
    }
    
    // MARK: - HomeServiceDelegate
    func didGetData(_ users: [User]?) {
        if let users = users {
            self.users += users
        } else {
            // No data retrieved, display "no items" view
            noItemsLabel.isHidden = false
        }
        
        loadingIndicator.removeFromSuperview()
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.USER_CELL, for: indexPath) as! UserCollectionViewCell
        cell.setValues(users[indexPath.item])
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = indexPath.item
        performSegue(withIdentifier: SegueIdentifier.USER_DETAIL_SEGUE, sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if homeService.nextPageExist {
            // Loads the next page of users when scroll reaches the last user
            if indexPath.item == users.count - 1 {
                homeService.requestData()
            }
        }
    }
    
    // You can set these in storyboard or programmatically like this
    // I'm setting it programmatically cause I'm calculating the sizes
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Sizing.userCellWidth, height: Sizing.userCellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Sizing.userCellMargin, left: Sizing.userCellMargin, bottom: Sizing.userCellMargin, right: Sizing.userCellMargin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Sizing.userCellMargin
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Sending the selected item data to the detail view controller
        if segue.identifier == SegueIdentifier.USER_DETAIL_SEGUE {
            let vc = segue.destination as! DetailViewController
            
            if let index = selectedItem {
                vc.user = users[index]
            }
        }
    }
}
