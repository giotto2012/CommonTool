//
//  UserDefaults.swift
//  LiveBid
//
//  Created by Taco on 2018/8/20.
//  Copyright © 2018年 Taco. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
        
    static let userLanguage = DefaultsKey<String?>("UserLanguage")
    static let newAppVersion = DefaultsKey<Int?>("NewAppVersion")
}
