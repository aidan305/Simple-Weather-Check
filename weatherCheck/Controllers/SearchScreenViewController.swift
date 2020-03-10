//
//  SearchScreenViewController.swift
//  weatherCheck
//
//  Created by Aidan Egan on 11/02/2020.
//  Copyright © 2020 Aidan Egan. All rights reserved.
//

import Foundation
import UIKit

protocol SearchProtocolDelegate: class {
    func cityAdded(city: City)
}

class SearchScreenViewController: UIViewController {

    @IBOutlet weak var searchTextBox: UITextField!
    weak var delegate: SearchProtocolDelegate?
    var parentController: CityListViewController?


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {

        let newCity = City(cityName: searchTextBox.text!)
        delegate?.cityAdded(city: newCity)

        self.dismiss(animated: true, completion: nil)
        searchTextBox.text = ""

        parentController?.cityTableView.reloadData()
    }
}



