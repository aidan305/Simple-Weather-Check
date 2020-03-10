//
//  City.swift
//  weatherCheck
//
//  Created by Aidan Egan on 10/02/2020.
//  Copyright © 2020 Aidan Egan. All rights reserved.
//

import Foundation

struct City: Codable {
    var cityName: String


    func getName() -> String {
        return cityName
    }
}

