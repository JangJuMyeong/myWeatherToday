//
//  Weather.swift
//  WeatherToday
//
//  Created by 장주명 on 2021/01/11.
//

import Foundation

struct Weather : Codable {
    
    let cityName : String
    let state : Int
    let celsius : Float
    let rainfallProbability : Int
    
    enum CodingKeys : String, CodingKey {
        case cityName = "city_name"
        case rainfallProbability = "rainfall_probability"
        case state, celsius
    }
    
}
