//
//  PhotoCell.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 05/11/2023.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    //MARK: - outlets
    @IBOutlet weak var movieImg: UIImageView!

    //MARK: - life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Public Methods
    func configure(path: String?) {
        movieImg.setImage(val: path)
    }
}
