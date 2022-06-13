//
//  GoogleAnalyticsManager.swift
//  FBhelper
//
//  Created by 張宇樑 on 2020/5/21.
//  Copyright © 2020 Taco. All rights reserved.
//

import Foundation
import Firebase

public class GoogleAnalyticsManager {
        

    public class func sendEvent(name:String,parameters:[String:Any]?)
    {

        Analytics.logEvent(name, parameters: parameters)
    }
    

}
