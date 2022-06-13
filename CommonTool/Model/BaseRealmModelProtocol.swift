//
//  BaseRealmModelProtocol.swift
//  LiveMap
//
//  Created by 張宇樑 on 2022/5/26.
//

import Foundation
public protocol BaseRealmModelProtocol
{
    func convertData(from decoder: Decoder) throws
}
