//
//  PublicFuncUtils.swift
//  FunShowLiveFramework
//
//  Created by 張宇樑 on 2021/12/8.
//

import Foundation

public func LocalString(key:String) -> String
{
    let string = LocalizeUtils.sharedInstance()._localized(withKey: key)
    
    return string
}


