//
//  WeatherDetailsViewController.swift
//  weatherCheck
//
//  Created by Aidan Egan on 16/02/2020.
//  Copyright © 2020 Aidan Egan. All rights reserved.
//

import Foundation
import UIKit

class WeatherDetailsViewController: UIViewController {


    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityTempLabel: UILabel!
    @IBOutlet var collectionView3dayWeather: UICollectionView!
    
    let weatherRepository = WeatherRepository()

    let testData = ["day1", "day2", "day3"]
    var allForecasts = [WeatherItems]()
    var allForecastsConverted = [WeatherDataConverted]()


    var city: City?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let city = city else {
            print("error")
            return
        }

        cityNameLabel.text = city.cityName


        weatherRepository.fetchWeather(city: city.cityName) { (weatherModel) in

            if let weather = weatherModel {

                DispatchQueue.main.async {
                    /// Access the UI back on the main queue.
                    self.cityTempLabel.text = "\(weather.main.temp)"
                }
            }
        }


        weatherRepository.fetchWeatherFor3Days(city: city.cityName) { (weather3DayDataModel) in
            if let weather = weather3DayDataModel {

                DispatchQueue.main.async {

                    for weatherItem in weather.list{

                        self.allForecasts.append(weatherItem)
                        //print(weatherItem.dt_txt, weatherItem.main.temp)
                    }
                     self.populateWeatherDataConvertedArray()

                }

            }
        }




        self.cityTempLabel.text = "No weather data "

    }

    func populateWeatherDataConvertedArray() {
        for items in allForecasts {
            let convertedItem = WeatherDataConverted(date: convertDate(dateString: items.dt_txt), temp: items.main.temp)
            allForecastsConverted.append(convertedItem)
        }

        getRelevantWeatherData()

    }

    func getRelevantWeatherData() {

        //Get tomorrows date
        let tomorrow = getWeatherDay1()
        let day2 = getWeatherDay2()
        let day3 = getWeatherDay3()
        var threeDayForecast = [WeatherDataConverted]()

        for i in 0...allForecastsConverted.count - 1 {
            if allForecastsConverted[i].date == tomorrow{
                print("this is tomorrows date \(allForecastsConverted[i].date) and this is the temp \(allForecastsConverted[i].temp)" )
                let dayForecast =  WeatherDataConverted(date: allForecastsConverted[i].date, temp: allForecastsConverted[i].temp)
                threeDayForecast.append(dayForecast)

            }

            if allForecastsConverted[i].date == day2{
                print("this is day2s date \(allForecastsConverted[i].date) and this is the temp \(allForecastsConverted[i].temp)" )
                let dayForecast =  WeatherDataConverted(date: allForecastsConverted[i].date, temp: allForecastsConverted[i].temp)
                threeDayForecast.append(dayForecast)

            }

            if allForecastsConverted[i].date == day3{
                print("this is day3s date \(allForecastsConverted[i].date) and this is the temp \(allForecastsConverted[i].temp)" )
                let dayForecast =  WeatherDataConverted(date: allForecastsConverted[i].date, temp: allForecastsConverted[i].temp)
                threeDayForecast.append(dayForecast)

            }


        }
        print3DayWeatherToCollectionView(dayForecasts: threeDayForecast)

        //Compare date in allForecastsConverted array to tomorrow
        //add date and temp to new array
        //pass array to print3DayWeatherToCollectionView()
    }

    func print3DayWeatherToCollectionView(dayForecasts: [WeatherDataConverted]) {

        for _ in 0..<dayForecasts.count {
            let indexPath = IndexPath(row: dayForecasts.count - 1, section: 0)
            collectionView3dayWeather.insertItems(at: [indexPath])
        }
    }

    func setTemp(temp: String)  {
        print(temp)
        cityTempLabel.text = temp
    }
}

    func convertDate(dateString: String) -> Date {
        var dateToReturn = Date()
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-d HH:mm:ss"

        if let date = dateFormatter.date(from: dateString)  {
            dateToReturn = date
        }
        return dateToReturn
    }

func getWeatherDay1() -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-d"

    var dateComponents = DateComponents()
    dateComponents.setValue(1, for: .day);

    let now = Date() // Current date
    var tomorrow = Date()

    if let tomorrowDate = Calendar.current.date(byAdding: dateComponents, to: now) {
        tomorrow = tomorrowDate
}

    //API response always has 21 hr for that date
    let dateToReturn = Calendar.current.date(bySettingHour: 21, minute: 00, second: 00, of: tomorrow)!

    return dateToReturn
}

func getWeatherDay2() -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-d"

    var dateComponents = DateComponents()
    dateComponents.setValue(2, for: .day);

    let now = Date() // Current date
    var tomorrow = Date()

    if let tomorrowDate = Calendar.current.date(byAdding: dateComponents, to: now) {
        tomorrow = tomorrowDate
}

    //API response always has 21 hr for that date
    let dateToReturn = Calendar.current.date(bySettingHour: 21, minute: 00, second: 00, of: tomorrow)!

    return dateToReturn
}

func getWeatherDay3() -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-d"

    var dateComponents = DateComponents()
    dateComponents.setValue(3, for: .day);

    let now = Date() // Current date
    var tomorrow = Date()

    if let tomorrowDate = Calendar.current.date(byAdding: dateComponents, to: now) {
        tomorrow = tomorrowDate
}

    //API response always has 21 hr for that date
    let dateToReturn = Calendar.current.date(bySettingHour: 21, minute: 00, second: 00, of: tomorrow)!

    return dateToReturn
}




/*

 1. Convert date string to Date format
 2. Add date and temp to Forecast array
 3. Scan through the array pick up tomorrow, tomorrow + 1 , tomorrow + 2
 4. Print day and temp to collection view labels
 */

//Code for handling collection view 3 day forecast
extension WeatherDetailsViewController : UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return testData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView3dayWeather.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)

        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = testData[indexPath.row]
        }

        if let label = cell.viewWithTag(200) as? UILabel {
            if allForecastsConverted.count > 0 {
                label.text = ("\(allForecastsConverted[indexPath.row].temp)")
            }
        }
        return cell
    }
}

