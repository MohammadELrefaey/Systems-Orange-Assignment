//
//  AlertController2.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import AVFoundation
import SwiftMessages
import AVFoundation
import UIKit

class AlertClass2 {
    
    //1311 virabte
    //1315 message alert ==  //1012 alert good yeaaa with viarabte

    //1302 error alert ,, 1113 , 1114
    //success 1035
    //waring 1309


    
    static func showMessageError(vc:UIViewController? = nil,title:String,message:String,infoTap:UITapGestureRecognizer?)
    {
        AudioServicesPlaySystemSound (1114)
        SwiftMessages.hide()
        let info = MessageView.viewFromNib(layout: .messageView)
        info.configureTheme(.error)
        info.button?.isHidden = true
        //info.iconImageView?.isHidden = true
//        info.configureDropShadow()
        info.sizeToFit()
        info.configureContent(title: title, body: message)
        info.alpha = 1
       // let infoTap = UITapGestureRecognizer(target: self, action: #selector(DoneClicked))
        if infoTap != nil{
        info.addGestureRecognizer(infoTap!)
        }
        var infoConfig = SwiftMessages.defaultConfig
        infoConfig.presentationStyle = .top
        if vc != nil{
            infoConfig.presentationContext = .view(vc!.view)
        }
        infoConfig.interactiveHide = true
        infoConfig.duration = .seconds(seconds: 3)
        infoConfig.ignoreDuplicates = false
        SwiftMessages.show(config: infoConfig, view: info)
        SwiftMessages.pauseBetweenMessages = 0
    }
    static func showMessageInfo(vc:UIViewController? = nil,title:String,message:String,infoTap:UITapGestureRecognizer?)
    {
        AudioServicesPlaySystemSound (1114)
        SwiftMessages.hide()
        let info = MessageView.viewFromNib(layout: .messageView)
        info.configureTheme(.info)
        info.button?.isHidden = true
        //info.iconImageView?.isHidden = true
//        info.configureDropShadow()
        info.sizeToFit()
        info.configureContent(title: title, body: message)
        info.alpha = 1
        // let infoTap = UITapGestureRecognizer(target: self, action: #selector(DoneClicked))
        if infoTap != nil{
            info.addGestureRecognizer(infoTap!)
        }
        var infoConfig = SwiftMessages.defaultConfig
        if vc != nil{
            infoConfig.presentationContext = .view(vc!.view)
        }
        infoConfig.presentationStyle = .top
        infoConfig.becomeKeyWindow = true
        infoConfig.duration = .seconds(seconds: 3)
        infoConfig.ignoreDuplicates = false
        
        SwiftMessages.show(config: infoConfig, view: info)
        SwiftMessages.pauseBetweenMessages = 0
    }
    
    static func showMessageSuccess22(vc:UIViewController? = nil,title:String,message:String,infoTap:UITapGestureRecognizer?) {
    
        AudioServicesPlaySystemSound (1114)
        SwiftMessages.hide()
        let info = MessageView.viewFromNib(layout: .cardView)
        info.configureTheme(.info)
//        info.configureTheme(backgroundColor: .c1LigthGreen, foregroundColor: .c2DarkGreen)
        info.button?.isHidden = true
        //info.iconImageView?.isHidden = true
    //        info.configureDropShadow()
        info.sizeToFit()
        info.configureContent(title: title, body: message,iconImage: UIImage.init(named: "checked (2)")!)
        info.alpha = 1
        // let infoTap = UITapGestureRecognizer(target: self, action: #selector(DoneClicked))
        if infoTap != nil{
            info.addGestureRecognizer(infoTap!)
        }
        var infoConfig = SwiftMessages.defaultConfig
        if vc != nil{
            infoConfig.presentationContext = .view(vc!.view)
        }
        infoConfig.presentationStyle = .top
        infoConfig.becomeKeyWindow = true
        infoConfig.duration = .seconds(seconds: 3)
        infoConfig.ignoreDuplicates = false

        SwiftMessages.show(config: infoConfig, view: info)
        SwiftMessages.pauseBetweenMessages = 0

        
    }
    
    static func showMessageError22(vc:UIViewController? = nil,title:String,message:String,infoTap:UITapGestureRecognizer?) {
    
        AudioServicesPlaySystemSound (1114)
        SwiftMessages.hide()
        let info = MessageView.viewFromNib(layout: .cardView)
        info.configureTheme(.info)
        let color = UIColor.red.withAlphaComponent(0.2)
        info.configureTheme(backgroundColor: color, foregroundColor: .red)
        info.button?.isHidden = true
        //info.iconImageView?.isHidden = true
    //        info.configureDropShadow()
        info.sizeToFit()
        info.configureContent(title: title, body: message,iconImage: UIImage.init(named: "Error")!)
        info.alpha = 1
        // let infoTap = UITapGestureRecognizer(target: self, action: #selector(DoneClicked))
        if infoTap != nil{
            info.addGestureRecognizer(infoTap!)
        }
        var infoConfig = SwiftMessages.defaultConfig
        if vc != nil{
            infoConfig.presentationContext = .view(vc!.view)
        }
        infoConfig.presentationStyle = .top
        infoConfig.becomeKeyWindow = true
        infoConfig.duration = .seconds(seconds: 3)
        infoConfig.ignoreDuplicates = false

        SwiftMessages.show(config: infoConfig, view: info)
        SwiftMessages.pauseBetweenMessages = 0

        
    }

    
    
    static func ShowErrorStatusBar(vc:UIViewController? = nil,message:String)
    {
        AudioServicesPlaySystemSound (1102)
        SwiftMessages.hide()
        let info = MessageView.viewFromNib(layout: .statusLine)
        info.configureTheme(.error)
        info.button?.isHidden = true
        //info.iconImageView?.isHidden = true
//        info.configureDropShadow()
        info.sizeToFit()
        info.configureContent(title: "", body: message)
        info.alpha = 1
        //  let infoTap = UITapGestureRecognizer(target: self, action: #selector(infoLocationTapped(sender:)))
        //  info.addGestureRecognizer(infoTap)
        var infoConfig = SwiftMessages.defaultConfig
        infoConfig.presentationStyle = .top
        //infoConfig.duration = .forever
        infoConfig.duration = .seconds(seconds: 3)
        if vc != nil{
            infoConfig.presentationContext = .view(vc!.view)
        }
        infoConfig.interactiveHide = true
        infoConfig.ignoreDuplicates = false
        SwiftMessages.show(config: infoConfig, view: info)
        SwiftMessages.pauseBetweenMessages = 0
    }
    
    static func ShowSuccessMessage(vc:UIViewController? = nil,message:String,interact:Bool?=nil, type: MessageView.Layout? = nil)
    {
        AudioServicesPlaySystemSound (1315)
        SwiftMessages.hide()
        let info = MessageView.viewFromNib(layout: type ?? .messageView)
        info.configureTheme(.success)
        info.button?.isHidden = true
        //info.iconImageView?.isHidden = true
//        info.configureDropShadow()
        info.sizeToFit()
        info.configureContent(title: "", body: message)
        info.alpha = 1
        //  let infoTap = UITapGestureRecognizer(target: self, action: #selector(infoLocationTapped(sender:)))
        //  info.addGestureRecognizer(infoTap)
        var infoConfig = SwiftMessages.defaultConfig
        infoConfig.presentationStyle = .top
        infoConfig.interactiveHide = true
        infoConfig.duration = .seconds(seconds: 3)
        if vc != nil{
            infoConfig.presentationContext = .view(vc!.view)
        }
        infoConfig.ignoreDuplicates = false
        SwiftMessages.show(config: infoConfig, view: info)
        SwiftMessages.pauseBetweenMessages = 0
    }
    
    static func ShowWarningMessage(vc:UIViewController? = nil,title: String,message:String,interact:Bool?=nil, type: MessageView.Layout? = nil)
    {
        
        SwiftMessages.hide()
        let info = MessageView.viewFromNib(layout: type ?? .messageView)
        info.configureTheme(.warning)
        info.button?.isHidden = true
        //info.iconImageView?.isHidden = true
//        info.configureDropShadow()
        info.sizeToFit()
        info.configureContent(title: title, body: message)
        info.alpha = 1
        //  let infoTap = UITapGestureRecognizer(target: self, action: #selector(infoLocationTapped(sender:)))
        //  info.addGestureRecognizer(infoTap)
        var infoConfig = SwiftMessages.defaultConfig
        infoConfig.presentationStyle = .top
        infoConfig.interactiveHide = true
        infoConfig.duration = .seconds(seconds: 3)
        if vc != nil{
            infoConfig.presentationContext = .view(vc!.view)
        }
        infoConfig.ignoreDuplicates = false
        SwiftMessages.show(config: infoConfig, view: info)
        SwiftMessages.pauseBetweenMessages = 0
    }

    
    
    static func vibrate() {
        AudioServicesPlaySystemSound (1311)
    }
    
    
    
    static func ShowErrorStatusBar2(vc:UIViewController? = nil,message:String)
        {
            hideAllMessages()
            let info = MessageView.viewFromNib(layout: .statusLine)
            info.configureTheme(.error)
            info.button?.isHidden = true
            //info.iconImageView?.isHidden = true
    //        info.configureDropShadow()
            info.sizeToFit()
            info.configureContent(title: "", body: message)
            info.alpha = 1
            //  let infoTap = UITapGestureRecognizer(target: self, action: #selector(infoLocationTapped(sender:)))
            //  info.addGestureRecognizer(infoTap)
            var infoConfig = SwiftMessages.defaultConfig
            infoConfig.presentationStyle = .top
            infoConfig.duration = .seconds(seconds: 3)
            if vc != nil{
                infoConfig.presentationContext = .view(vc!.view)
            }
            infoConfig.interactiveHide = true
            infoConfig.ignoreDuplicates = false
            SwiftMessages.show(config: infoConfig, view: info)
            SwiftMessages.pauseBetweenMessages = 0
        }
    
    static func hideAllMessages(){
        SwiftMessages.hide()
    }
    
    static func errorSound() {
        AudioServicesPlaySystemSound (1311)
    }
    


    
}
