//
//  PageHeaderView.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 04/11/2023.
//

import Foundation
import UIKit

class PageHeaderView: UIView {
    
    var hideBack = false {
        didSet {
            backBtn.isHidden = hideBack
        }
    }
    
    var title: String? {
        didSet {
            if let title = title {
                titleLbl.text = title
                self.titleLbl.isHidden = false
            } else {
                self.titleLbl.isHidden = true
            }
        }
    }
    
    var onBackPressed: (()->())?

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
        titleLbl.isHidden = true
        backBtn.addTapGestureRecognizer {[weak self] in
            guard let self = self else {return}
            self.onBackPressed?()
        }
    }
}
