//
//  Data+Extension.swift
//  CommonTool
//
//  Created by 張宇樑 on 2022/6/16.
//

import Foundation

extension Data
{
    public func dataToDic() -> [String:Any]?
    {
        var d:[String:Any]?
        
        do {
            let dic =  try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
            
            
            d = dic
            
            
            
        } catch {
            
            
        }
        
        
        return d
        
    }
}
