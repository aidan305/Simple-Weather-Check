//
//  WeatherData.swift
//  weatherCheck
//
//  Created by Aidan Egan on 16/02/2020.
//  Copyright © 2020 Aidan Egan. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    public var main: Main
}

struct Main:Codable {
    public var temp: Double
    
}
