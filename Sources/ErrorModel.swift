//
//  ErrorModel.swift
//  FunShowToolFramework
//
//  Created by 張宇樑 on 2022/1/21.
//

import Foundation
public struct ErrorBaseModel {
    public var message : String = ""
    public var code : Int = 0
    
    public init() {
        
        
    }
}
extension ErrorBaseModel:Codable
{
    enum CodingKeys: String, CodingKey {

        case message = "message"
        case code = "code"
    }
    
   
    public init(from decoder: Decoder) throws {
                
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        
        code = try values.decodeIfPresent(Int.self, forKey: .code) ?? 0
        
    }
}
