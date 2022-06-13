//
//  CustomError.swift
//  LiveBid
//
//  Created by Taco on 2018/11/7.
//  Copyright © 2018年 Taco. All rights reserved.
//

import Foundation

public class CustomError:NSObject  {
    
    public var statusCode:Int?

    public var errorCode:Int?
    
    public var errorMessage:String = ""

    public var errorDic:Dictionary<String,Any>?
    
    public var errorResult:Any?
    
    public required init(errorCode:Int?,message:String = "",error:NSError = NSError(domain: "", code: 0, userInfo: nil),statusCode:Int,result:Any? = nil) {
        
        super.init()
        
        self.errorCode = errorCode
        
        self.statusCode = statusCode
        
        if message.count > 0
        {
            errorMessage = message
        }
        else
        {
            errorMessage = generalErrorMessage(code: errorCode ?? 0, error: error)
        }
        
        errorDic = error.userInfo
        errorResult = result
        
    }
    
    public required init(code:Int,message:String = "",error:NSError = NSError(domain: "", code: 0, userInfo: nil)) {
        
        super.init()
        
        errorCode = code
        
        if code == 0 && message.count > 0
        {
            errorMessage = message
        }
        else if message.count == 0
        {
            errorMessage = generalErrorMessage(code: errorCode ?? 0, error:error)
        }
        else
        {
            errorMessage = message

        }
                
        errorDic = error._userInfo as? Dictionary<String, Any>
        
    }
    
    func generalErrorMessage(code:Int,error:NSError) -> String {
        
        if let detialError:Error = error._userInfo?[NSUnderlyingErrorKey] as? Error
        {
            if detialError._code == NSURLErrorNotConnectedToInternet || detialError._code == NSURLErrorCannotConnectToHost
            {
                return  LocalizeUtils.sharedInstance()._localized(withKey: "Error_NotNetwork_Message")
            }
            else if (detialError._code == NSURLErrorTimedOut)
            {
                return LocalizeUtils.sharedInstance()._localized(withKey:"Error_Timeout_Message")
            }
            else
            {
                return LocalizeUtils.sharedInstance()._localized(withKey:"Error_Other_Message")
            }
        }
        else
        {
            switch code {
                
            case 500...600:
                
                return LocalizeUtils.sharedInstance()._localized(withKey: "Error_Server_Message")
            case 400...500:
                
                return LocalizeUtils.sharedInstance()._localized(withKey: "Error_Client_Message")
                
            default:
                return LocalizeUtils.sharedInstance()._localized(withKey: "Error_Other_Message")
            }
        }
    }
}
