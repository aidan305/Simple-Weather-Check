//
//  CityListViewController.swift
//  weatherCheck
//
//  Created by Aidan Egan on 10/02/2020.
//  Copyright © 2020 Aidan Egan. All rights reserved.
//

import UIKit

class CityListViewController: UIViewController {

    @IBOutlet weak var cityTableView: UITableView!
    var searchScreenViewController: SearchScreenViewController?
    let fileManagerController = FileManagerController()
    //let weatherManagerUtility = WeatherManagerutility()
    var cities : [City] = []

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        populateCities()
        searchScreenViewController = self.storyboard?.instantiateViewController(identifier: "SearchScreenViewControllerID")
        searchScreenViewController?.delegate = self
        
        cityTableView.delegate = self
        cityTableView.dataSource = self
    }

    func populateCities(){
        cities = fileManagerController.readDataFromFile()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cityTableView.reloadData()
    }

    func copyDecodedArrayToGlobal(decodedArray: [City]) {
        cities = decodedArray
    }

    @IBAction func onTapAddCity(_ sender: Any) {
        if let controller = searchScreenViewController {

            present(controller, animated: true, completion: nil)
        }
    }
}

extension CityListViewController: UITableViewDataSource, UITableViewDelegate{

    //functions needed for inserting row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = cities[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCellLabel") as! CityCell
        
        cell.setCity(city: city)
        
        return cell
    }

    //functions needed for selecting row - instantiate the view controller for weather details, push the view controller and update the temp label to hold city name 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let weatherDetailsViewController = self.storyboard?.instantiateViewController(identifier: "WeatherDetailsViewControllerID") as WeatherDetailsViewController? {

            let city = cities[indexPath.row]
            weatherDetailsViewController.city = city

            navigationController?.pushViewController(weatherDetailsViewController, animated: true)
        }
    }


    //functions needed for deleting row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            cities.remove(at: indexPath.row)
            fileManagerController.deleteRowFromFile(updatedArray: cities)
            cityTableView.reloadData()
        }
    }
}

extension CityListViewController: SearchProtocolDelegate {

    func cityAdded(city: City) {
        cities.append(city) // add city to array
        cityTableView.reloadData() // refresh table
        let fileManagerController = FileManagerController()
        fileManagerController.saveCityToFile(cityArray: cities)
        // decide where save the date to the json file
    }
}

