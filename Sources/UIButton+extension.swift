//
//  UIButton+extension.swift
//  FBhelper
//
//  Created by 張宇樑 on 2019/7/2.
//  Copyright © 2019 Taco. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    public func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
    
    
    public func setButtonTitleMinimumScaleFactor(scale:CGFloat)
    {
        self.titleLabel?.numberOfLines = 1
               
        self.titleLabel?.adjustsFontSizeToFitWidth = true
               
        self.titleLabel?.minimumScaleFactor = scale
    }
    
//    override open var isEnabled: Bool {
//            didSet {
//                if self.isEnabled {
//                    self.alpha = 1.0
//                }
//                else {
//                    self.alpha = 0.5
//                }
//                //make sure button is updated
//                self.layoutIfNeeded()
//            }
//        }

}
