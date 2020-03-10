//
//  Weather3DayData.swift
//  weatherCheck
//
//  Created by Aidan Egan on 05/03/2020.
//  Copyright © 2020 Aidan Egan. All rights reserved.
//

import Foundation


struct Weather3DayData: Codable {
     public var list: [WeatherItems]
}

struct WeatherItems: Codable {
    public var main: main
    public var dt_txt: String
}

struct main: Codable{
    public var temp: Double
}
