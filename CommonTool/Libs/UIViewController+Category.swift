//
//  UIViewController+Category.swift
//  LiveBid
//
//  Created by Taco on 2018/10/4.
//  Copyright © 2018年 Taco. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func tabBarIsVisible() ->Bool {
        
        
        return self.tabBarController!.tabBar.frame.origin.y <= self.view.frame.maxY
    }
    
    
    public func showAlear(message:String)
    {
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: LocalizeUtils.sharedInstance()._localized(withKey: "Define"), style: .cancel, handler: nil)
            
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            
        }
        
        
    }
    
    
    @objc open func currentViewControllerShouldPop() -> Bool
    {
        return true
    }
}

