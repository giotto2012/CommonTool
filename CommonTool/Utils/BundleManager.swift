//
//  RealmManager.swift
//  FBhelper
//
//  Created by 張宇樑 on 2020/8/21.
//  Copyright © 2020 Taco. All rights reserved.
//

import Foundation

public class BundleManager {
    
    private static var mInstance:BundleManager?
        
    private var _bundle:Bundle
    
    static func sharedInstance() -> BundleManager {
        
        if mInstance == nil {
            
            mInstance = BundleManager()
            
        }
        
        return mInstance!
    }
    
    public class func bundle() -> Bundle
    {
        return BundleManager.sharedInstance()._bundle
    }
    
    init() {
        
        _bundle = Bundle.init(for: type(of: self))
        
    }

    
    


}
