//
//  PageHeaderView.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 04/11/2023.
//

import Foundation
import UIKit

class PageHeaderView: UIView {
    
    var hideBack = true
    var onBackPressed: (()->())?
    var titleText: String?
    
    //outlets
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var contentView: UIView!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commit()
    }
    
    func commit(){
        Bundle.main.loadNibNamed("PageHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask  = [.flexibleHeight,.flexibleWidth]
        self.setupUI()
    }
    
    func setupUI() {
        titleLbl.text = titleText
        backBtn.isHidden = hideBack
        backBtn.addTapGestureRecognizer {[weak self] in
            guard let self = self else {return}
            self.onBackPressed?()
        }
        
    }
}
