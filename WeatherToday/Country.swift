//
//  country.swift
//  WeatherToday
//
//  Created by 장주명 on 2021/01/11.
//

import Foundation

struct Country : Codable {
    let koreanname : String
    let assetname : String
    
    enum CodingKeys : String, CodingKey {
        case koreanname = "korean_name"
        case assetname = "asset_name"
    }
}
