//
//  RefreshTokenManger.swift
//  FBhelper
//
//  Created by 張宇樑 on 2022/2/24.
//  Copyright © 2022 Taco. All rights reserved.
//

import Foundation
import UIKit

class RefreshTokenManger
{
    private static var mInstance:RefreshTokenManger?
        
    var isRefresh = false
    
    var requestArray:[ ()->()] = []
    
    static func sharedInstance() -> RefreshTokenManger {
        
        if mInstance == nil {
            
            mInstance = RefreshTokenManger()
            
        }
        
        return mInstance!
    }
    
    func refreshToken(delegate:APIMangerProtocol,finsh: @escaping ()->())
    {
        requestArray.append(finsh)
        
        if isRefresh == false
        {
            isRefresh = true
            
            delegate.requestRefreshToken { [self] in
                
                refreshFinsh()
                
            } failure: { error in
                
                
            }
            
        }
    }
    
    func refreshFinsh()
    {
        for f in requestArray
        {
            f()
        }
        
        isRefresh = false
        
        requestArray.removeAll()
    }
    
    
}
