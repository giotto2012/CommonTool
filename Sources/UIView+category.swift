//
//  UIView+category.swift
//  LiveBid
//
//  Created by Taco on 2018/8/15.
//  Copyright © 2018年 Taco. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    public func loadUINib() -> UINib
    {
        let bundle = Bundle(for: type(of: self))
        
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib
    }
    
    public func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    public func setLayerCircle()
    {
        self.layer.cornerRadius = self.frame.width/2
        
        self.clipsToBounds = true

    }
    
    public func setBorder(color:UIColor = UIColor.gray,width:CGFloat = 1)
    {
        self.layer.borderWidth = width
        
        self.layer.borderColor = color.cgColor

    }
    
    public func setLayerOval(boardColor:UIColor = UIColor.clear,bgColor:UIColor = UIColor.clear)
    {
        let backgroundLayer = CAShapeLayer()
        
        backgroundLayer.name = "background"
        
        backgroundLayer.frame = self.bounds
          
        if boardColor == UIColor.clear
        {
            backgroundLayer.lineWidth = 0
        }
        else
        {
            backgroundLayer.lineWidth = 1
        }
        backgroundLayer.strokeColor = boardColor.cgColor
        backgroundLayer.fillColor = bgColor.cgColor
        
        let path = UIBezierPath()
        
        path.move(to: .zero)
        
        let bgH = self.bounds.height
        let bgW = self.bounds.width
                
        path.move(to: CGPoint(x: bgH/2, y: 0))
        
        path.addLine(to: CGPoint(x: bgW-bgH/2, y: 0))
        
        path.addArc(withCenter: CGPoint(x: bgW-bgH/2, y: bgH/2), radius: bgH/2, startAngle: -.pi/2, endAngle: .pi/2, clockwise: true)
        
        path.addLine(to: CGPoint(x: bgH/2, y: bgH))
        
        path.addArc(withCenter: CGPoint(x: bgH/2, y: bgH/2), radius: bgH/2, startAngle: .pi/2, endAngle:-.pi/2 , clockwise: true)

        
        backgroundLayer.path = path.cgPath
                        
//        if self.layer.sublayers == nil
//        {
//            self.layer.insertSublayer(backgroundLayer, at: 0)
//
//        }
        if let sublayers = self.layer.sublayers
        {
            for layer in sublayers
            {
                if layer.name == "background"
                {
                    layer.removeFromSuperlayer()
                }
            }
        }
    
        self.layer.insertSublayer(backgroundLayer, at: 0)
        
    }
}
