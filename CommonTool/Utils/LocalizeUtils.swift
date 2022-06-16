//
//  LocalizeUtils.swift
//  SwitchLanguageDemo
//
//  Created by Frank.Chen on 2018/4/5.
//  Copyright © 2018年 frank.chen. All rights reserved.
//

import UIKit
import SwiftyUserDefaults


public protocol LanguageProtocol
{
    func changeLanguage(key: String)
}

extension LanguageProtocol
{
    
    public  func changeLanguage(key: String)
    {
        var code:String?
        
        if key == "zh_tw"
        {
            code = "zh-Hant-TW"
        }
        else if key == "zh_cn"
        {
            code = "zh-Hant-CN"
        }
        else if key == "thai"
        {
            code = "th"
        }
        else if key == "malay"
        {
            code = "ms"
        }
        else if key == "en"
        {
            code = "en"
        }
        else
        {
            code = "zh-Hant-TW"
        }
        
        Defaults[\.userLanguage] = code
       
    }
}


open class LocalizeUtils {
    
    
    public var delegate:LanguageProtocol?
    
    private static var shared:LocalizeUtils?
    
    public static func sharedInstance() -> LocalizeUtils {
        
        if shared == nil {
            
            shared = LocalizeUtils()
            
            shared?.delegate = shared
        }
        
        return shared!
    }
        
    
    public class func localized(withKey key: String) -> String
    {
        let string = sharedInstance()._localized(withKey: key)
        
        return string
    }
    
    public func _localized(withKey key: String,bundle:Bundle = BundleManager.bundle()) -> String {
        
        let localizationFileNmae:String? = Defaults[\.userLanguage]
        
        if localizationFileNmae?.count ?? 0 > 0
        {
            if let path = bundle.path(forResource: localizationFileNmae, ofType: "lproj")
            {
                if let b = Bundle(path: path)
                {
                    return NSLocalizedString(key, tableName: nil, bundle: b, value: "", comment: "")

                }
                else
                {
                    return key
                }
            }
            else
            {
                return key
            }
            
        }
        else
        {
            return key
        }
        
    }
    
    public class func apiHaderKey() -> String
    {
        let localizationFileNmae:String? = Defaults[\.userLanguage]
        
        if let localizationFileNmae = localizationFileNmae
        {
            switch localizationFileNmae {
            case "zh-Hant-TW":
                return "zh_TW"
            case "zh-Hant-CN":
                return "zh_CN"
            case "en":
                return "en"
            default:
                return "zh_TW"
            }
        }
        else
        {
            return "zh_TW"
        }
    }
    
    
    public func changeLanguage(withCode key: String) {
        
        delegate?.changeLanguage(key: key)
        
    }
    
    
    
    
    public func settingUserLanguageCode() {
        
        let localizationFileNmae:String? = Defaults[\.userLanguage]
        
        guard localizationFileNmae == nil else{
            
            return 
            
        }
                
        let preferredLanguages: String = Locale.preferredLanguages.first!
        
        let currentLanguageCode = preferredLanguages.split(separator: "-")[0] // Hant、Hans

        var code:String?
        
        if currentLanguageCode == "zh"
        {
            
            if preferredLanguages.contains("Hant")
            {
                code = "zh-Hant-TW"
            }
            else
            {
                code = "zh-Hant-CN"
            }

        }
        else if currentLanguageCode == "ms"
        {
            code = "ms"
        }
        else if currentLanguageCode == "th"
        {
            code = "th"
        }
        else if currentLanguageCode == "en"
        {
            code = "en"
        }
        else
        {
            code = "zh-Hant-TW"
        }
        
        Defaults[\.userLanguage] = code

        
    }
    
}
extension LocalizeUtils:LanguageProtocol
{
    
}
