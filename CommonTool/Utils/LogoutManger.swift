//
//  LogoutManger.swift
//  FunShowLiveFramework
//
//  Created by 張宇樑 on 2021/11/24.
//

import Foundation

open class LogoutManger
{
    open class func logout()
    {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: LogoutNotificationKey), object: [:])
    }
}
