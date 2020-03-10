//
//  WeatherDataConverted.swift
//  weatherCheck
//
//  Created by Aidan Egan on 08/03/2020.
//  Copyright © 2020 Aidan Egan. All rights reserved.
//

import Foundation

class WeatherDataConverted {
    public var date: Date
    public var temp: Double = 0.0

    init(date: Date, temp: Double) {
        self.date = date
        self.temp = temp
    }

}
