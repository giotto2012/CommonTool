//
//  UIColor+Category.swift
//  LiveBid
//
//  Created by Taco on 2018/8/6.
//  Copyright © 2018年 Taco. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    public class var primaryColor: UIColor {
        
        let color = UIColor.hexStringToUIColor(hex: "#0097A7")
        
        return color
    }
    
    public class var primaryLighterColor: UIColor {
        
        let color = UIColor.hexStringToUIColor(hex: "#56C8D8")
        
        return color
    }
    
    public class var primaryDarkerColor: UIColor {
        
        let color = UIColor.hexStringToUIColor(hex: "#006978")
        
        return color
    }
    
    
    public class var secondaryColor: UIColor {
        
        let color = UIColor.hexStringToUIColor(hex: "#FFECB3")
        
        return color
    }
    
    public class var secondaryLighterColor: UIColor {
        
        let color = UIColor.hexStringToUIColor(hex: "#FFFFE5")
        
        return color
    }
    
    public class var secondaryDarkerColor: UIColor {
        
        let color = UIColor.hexStringToUIColor(hex: "#CBBA83")
        
        return color
    }
    
    
    public class var lineColor: UIColor {
        
        let color = UIColor.hexStringToUIColor(hex: "#E0E0E0")
        
        return color
    }
    
    
    public class var mainRed: UIColor {
        
        let color = UIColor.hexStringToUIColor(hex: "E63C3C")
        
        return color
    }
    
    public class var mainGary: UIColor {
        
        let color = UIColor.hexStringToUIColor(hex: "c8c8c8")
        
        return color
    }
    
    public class var mainGreen: UIColor {
        
        let color = UIColor.hexStringToUIColor(hex: "32b4be")
        
        return color
    }
    
    public class var textBlack: UIColor {
        
        let color = UIColor.hexStringToUIColor(hex: "323232")
        
        return color
    }
    
    public static func hexStringToUIColor (hex:String,alpha:CGFloat = 1.0) -> UIColor {
        
        if hex.hasPrefix("rgba")
        {
            //rgba(128,103,103,1)
            let hex1 = hex.replacingOccurrences(of: "rgba(", with: "")
            let hex2 = hex1.replacingOccurrences(of: ")", with: "")

            let components = hex2.components(separatedBy: ",")
            
            let r = Float(components[0]) ?? 0
            let g = Float(components[1]) ?? 0
            let b = Float(components[2]) ?? 0
            let a = Float(components[3]) ?? 1
            
            return UIColor(
                red: CGFloat(r / 255.0),
                green: CGFloat(g / 255.0),
                blue: CGFloat(b / 255.0),
                alpha: CGFloat(a)
            )
        }
        else
        {
            var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            
            if (cString.hasPrefix("#")) {
                cString.remove(at: cString.startIndex)
            }
            
            if ((cString.count) != 6) {
                return UIColor.gray
            }
            
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: alpha
            )
        }
        
        
    }
    public  static func == (l: UIColor, r: UIColor) -> Bool {
        var r1: CGFloat = 0
        var g1: CGFloat = 0
        var b1: CGFloat = 0
        var a1: CGFloat = 0
        l.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var a2: CGFloat = 0
        r.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        return r1 == r2 && g1 == g2 && b1 == b2 && a1 == a2
    }
    
    public var hexString: String {
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0
        
        return String(format: "#%06x", rgb)
    }
}


