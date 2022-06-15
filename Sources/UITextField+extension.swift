//
//  UITextField+extension.swift
//  FBhelper
//
//  Created by 張宇樑 on 2020/11/2.
//  Copyright © 2020 Taco. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
        
    public func setLeftPadding(padding:CGFloat = 5)
    {
       let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        
        self.leftViewMode = UITextField.ViewMode.always
                
        self.leftView = paddingView
    }
}
