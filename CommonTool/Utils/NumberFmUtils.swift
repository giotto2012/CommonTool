//
//  NumberFmUtils.swift
//  FBhelper
//
//  Created by 張宇樑 on 2021/7/30.
//  Copyright © 2021 Taco. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

public class NumberFmUtils: NSObject {
    
    static let shared = NumberFmUtils()
    
    var fm = NumberFormatter()
    
    public class func defaultDecimalFormatter() -> NumberFormatter
    {
        
        shared.fm.maximumFractionDigits = 2
        
        return shared.fm
    }
    
    
    
}
