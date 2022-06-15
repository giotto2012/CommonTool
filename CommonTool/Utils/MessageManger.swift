//
//  MessageManger.swift
//  LiveBid
//
//  Created by Taco on 2018/11/22.
//  Copyright © 2018年 Taco. All rights reserved.
//

import Foundation
import SwiftMessages

public class MessageManger:NSObject
{
    private static var mInstance:MessageManger?
    
    var messageView:MessageView
    
    
    static func sharedInstance() -> MessageManger {
        
        if mInstance == nil {
            
            mInstance = MessageManger()
            
        }
        
        return mInstance!
    }
    
    override init() {
        
        messageView = MessageView.viewFromNib(layout: .messageView)
        
        messageView.button?.isHidden = true
        
        messageView.iconLabel?.isHidden = true
        
        messageView.configureDropShadow()
        
        messageView.configureTheme(backgroundColor: .red, foregroundColor: .white)
        
        messageView.titleLabel?.isHidden = true
        
        SwiftMessages.defaultConfig.presentationContext = .window(windowLevel: .statusBar)

        
        
        super.init()
    }
    
    func _showErrorMessage(title:String = "",message:String,viewController:UIViewController? = nil)
    {
        messageView.configureTheme(.error, iconStyle: .light)
        
        messageView.configureContent(title: title, body: message )
                
        SwiftMessages.show(view: messageView)
    }
    
    
    func _showSuccesMessage(message:String,viewController:UIViewController? = nil)
    {
        messageView.configureTheme(.success, iconStyle: .light)
        
        messageView.configureContent(title: "", body: message)
                
        SwiftMessages.show(view: messageView)
        
        
    }
    
    
    
    func _showInfoMessage(message:String,viewController:UIViewController? = nil)
    {
        let iconImage = IconStyle.light.image(theme: Theme.info)
        
//        messageView.configureTheme(.info, iconStyle: .light)
//        
//        messageView.configureTheme(backgroundColor: UIColor.red, foregroundColor:UIColor.white)
                
        messageView.configureTheme(backgroundColor: UIColor.white, foregroundColor: UIColor.black, iconImage: iconImage)
        
        
        messageView.configureContent(title: "", body: message)
        
        var config = SwiftMessages.Config()
        
        SwiftMessages.show(view: messageView)
        
        
    }
    
    public class func showErrorMessage(title:String = "", message:String,viewController:UIViewController? = nil)
    {
        MessageManger.sharedInstance()._showErrorMessage(title:title,message: message,viewController:viewController)
    }
    
    
    public class func showSuccessMessage(message:String,viewController:UIViewController? = nil)
    {
        MessageManger.sharedInstance()._showSuccesMessage(message: message,viewController:viewController)
    }
    
    public class func showInfoMessage(message:String,viewController:UIViewController? = nil)
    {
        MessageManger.sharedInstance()._showInfoMessage(message: message,viewController:viewController)
    }
}
