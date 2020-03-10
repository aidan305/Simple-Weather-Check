//
//  CityCell.swift
//  weatherCheck
//
//  Created by Aidan Egan on 10/02/2020.
//  Copyright © 2020 Aidan Egan. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {


    @IBOutlet weak var cityNameLabel: UILabel!
    

    func setCity(city: City) {
        cityNameLabel.text = city.cityName
    }
}
