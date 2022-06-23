//
//  RealmManager.swift
//  FBhelper
//
//  Created by 張宇樑 on 2020/8/21.
//  Copyright © 2020 Taco. All rights reserved.
//

import Foundation
import RealmSwift

public class RealmManager {
    
    private static var mInstance:RealmManager?
            
    public var realm:Realm {
        get {
          return try! Realm()
        }
      }
    
    
    public static func sharedInstance() -> RealmManager {
        
        if mInstance == nil {
            
            mInstance = RealmManager()
            
        }
        
        return mInstance!
    }

    
    


}
