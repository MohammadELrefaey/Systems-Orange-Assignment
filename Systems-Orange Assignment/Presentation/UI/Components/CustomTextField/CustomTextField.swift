//
//  CustomTextField.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 04/11/2023.
//


import UIKit

class CustomTextField: UIView {

    //MARK: - Properties
    var didBeginEdit: (()->())?
    var didEndEdit: (()->())?
    var onChangeText: ((String?)->())?

    //MARK: - Outlets
    @IBOutlet weak var CLeadingView: NSLayoutConstraint!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblPlaceHolder: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var vuContain: UIView!
    
    //MARK: - Actions
    @IBAction func textFieldDidChangeText(_ sender: Any) {
        self.onChangeText?(self.textField.text!)
    }
    
    //MARK: - Initilizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commit()
        
    }
    
    func commit(){
        Bundle.main.loadNibNamed("CustomTextField", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask  = [.flexibleHeight,.flexibleWidth]
        setupUI()
        
    }


    //MARK: - Methods
    func setupUI () {
        self.lblPlaceHolder.isHidden = true
        self.vuContain.backgroundColor = UIColor.white
        self.image = nil
        self.errorMessage = ""
        textField.addTarget(self, action: #selector(didbeginWrite), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(didendWrite), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(didclickedPrimaryKey), for: .primaryActionTriggered)
        self.isSecure = false
        self.textField.returnKeyType = .done
        self.backgroundColor = UIColor.clear
    }
    
    var image: UIImage? {
        didSet {
            self.icon.isHidden = (image == nil)
            self.icon.image = image
        }
    }
    
    
    var placeHolder: String? {
        didSet {
            self.lblPlaceHolder.text = self.placeHolder
            self.textField.placeholder = self.placeHolder
            
        }
    }
    
    
//    //border half of height with shadow
    func setCustomStyle() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
            self.vuContain.applyDefaultBor()
        })
    }
    
    var keyboardType: UIKeyboardType? {
        didSet {
            self.textField.keyboardType = self.keyboardType ?? UIKeyboardType.default
        }
    }
    
    var text: String? {
        get {
            return self.textField.text
        }
        
        set {
            self.textField.text = newValue
            if newValue == "" || newValue == nil {
                self.lblPlaceHolder.alpha = 0
                self.lblPlaceHolder.isHidden = true
            }else {
                self.lblPlaceHolder.alpha = 1
                self.lblPlaceHolder.isHidden = false
            }
        }
    }
    
    var isSecure: Bool? {
        didSet {
            self.textField.isSecureTextEntry = isSecure ?? false
        }
    }
    
    var errorMessage : String? {
        didSet {
            if (self.errorMessage ?? "") == "" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
//                    self.lblPlaceHolder.isHidden = true
                    self.lblPlaceHolder.text = self.placeHolder
                    self.lblPlaceHolder.textColor = .gray
                    self.layoutIfNeeded()
                    if self.textField.text == "" {
                        self.lblPlaceHolder.alpha = 0
                    }else{
                        self.lblPlaceHolder.alpha = 1
                    }
                    self.textField.textColor = .black
                    self.vuContain.layer.borderColor = UIColor.clear.cgColor
                })
            }else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
                    self.lblPlaceHolder.isHidden = false
                    self.lblPlaceHolder.text = self.errorMessage
                    self.lblPlaceHolder.textColor = UIColor.red
                    self.vuContain.layer.borderColor = UIColor.red.cgColor
                    self.layoutIfNeeded()
                    self.textField.textColor = UIColor.red
                    self.fadelblPlaceHolder(1)
                })
            }
        }
    }
}

// animation
extension CustomTextField {
    
    func fadelblPlaceHolder(_ alpha: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.lblPlaceHolder.alpha = alpha
            self.lblPlaceHolder.isHidden = alpha > 0 ? false : true
        }
    }
    
}

//textFild Clicking Handle
extension CustomTextField {
    
    @objc func didbeginWrite() {
        fadelblPlaceHolder(1)
        didBeginEdit?()
    }
    
    @objc func didendWrite() {
        if (self.errorMessage ?? "" ) == "" && self.textField.text == "" {
            fadelblPlaceHolder(0)
        }
        errorMessage = nil
        didEndEdit?()
    }
    
    @objc func didclickedPrimaryKey() {
        self.textField.endEditing(true)
    }
}

