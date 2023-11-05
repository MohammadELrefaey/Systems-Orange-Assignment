//
//  UICollectionView+FitHeght.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 05/11/2023.
//

import Foundation

import UIKit

extension UICollectionView {
    
    func transition(collectionView: UICollectionView) {
        UIView.transition(with: collectionView, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            //Do the data reload here
            collectionView.reloadData()
        }, completion: nil)
    }
    
    func fitHeightToContent(view: UIView, heightConstraint: NSLayoutConstraint) {
        
        heightConstraint.constant = self.collectionViewLayout.collectionViewContentSize.height
        view.setNeedsLayout()
        self.reloadData()
    }
    
}
