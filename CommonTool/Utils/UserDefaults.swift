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
        
    var userLanguage: DefaultsKey<String?> { .init("UserLanguage") }
    var newAppVersion: DefaultsKey<Int?> { .init("NewAppVersion") }
    var isNotFirstRun: DefaultsKey<Bool?> { .init("FBhelperFirstRun") }
}
