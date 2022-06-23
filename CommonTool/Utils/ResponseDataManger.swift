//
//  ResponseDataManger.swift
//  CommonTool
//
//  Created by 張宇樑 on 2022/6/21.
//

import Foundation

public class ResponseDataManger
{
    public class func getAndCheckData<T:Decodable>(type:T.Type,data:Data?,failure: @escaping (CustomError)->()) -> T?
    {
        let decoder = JSONDecoder()
        
        if let d = data
        {
            if let songResults = try?
                decoder.decode(type, from: d)
            {
                return songResults
                
            } else {
                
                failure(CustomError(code: 500))
                
                return nil
            }
        }
        else
        {
            failure(CustomError(code: 500))
            
            return nil
        }
        
    }
}
