//
//  KeychainManger.swift
//  LiveBid
//
//  Created by Taco on 2018/12/5.
//  Copyright © 2018年 Taco. All rights reserved.
//

import Foundation

import KeychainAccess


public class KeychainManger
{
    public static let keychainService = "com.ylc.account"
    
    public static let keychainTokenKey = "keychain_token"
        
    public static let keychainExpiredTimestampKey = "keychain_expiredTimestamp"

    public class func isValid(key:String) -> Bool
    {
        let keychain = Keychain(service: keychainService)
        
        let value = keychain[key]
        
        if value != nil
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    public class func setValue(value:String,key:String)
    {
        let keychain = Keychain(service: keychainService)
        
        keychain[key] = value
    }
    
    public class func getValue(key:String) -> String?
    {
        let keychain = Keychain(service: keychainService)
        
        let value = keychain[key]
        
        return value
    }
    
    public class func removeValue(key:String)
    {
        let keychain = Keychain(service: keychainService)
        
        try? keychain.remove(key)
    }
    
    public class func removeAllValue()
    {
        let keychain = Keychain(service: keychainService)
        
        try? keychain.removeAll()
    }
}
