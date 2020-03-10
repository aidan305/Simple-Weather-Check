//
//  WeatherManagerUtility.swift
//  weatherCheck
//
//  Created by Aidan Egan on 16/02/2020.
//  Copyright © 2020 Aidan Egan. All rights reserved.
//

import Foundation
// https://www.hackingwithswift.com/books/ios-swiftui/sending-and-receiving-codable-data-with-urlsession-and-swiftui


class WeatherRepository {

    func performRequest(city: String) {

        var temperature = String()

        let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=07a44fd531e1944590289075b754402c&units=metric&q=\(city)"

        if let url = URL(string: weatherURL){
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { (data, response, error) in

                DispatchQueue.main.async {
                let decoder = JSONDecoder()
                do{
                    let temp = try decoder.decode(WeatherData.self, from: data!)
                    print("the temp for london is \(temp.main.temp)")
                    temperature = String(temp.main.temp)


                    let weatherDetailsVC = WeatherDetailsViewController()
                    weatherDetailsVC.setTemp(temp: temperature)

                }
                catch (let error) {
                    print("error decoding \(error)")
                }
                }
            }.resume()
        }
    }

    func fetchWeather(city: String, completion: @escaping (WeatherData?) -> Void) {

        let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=07a44fd531e1944590289075b754402c&units=metric&q=\(city)"

        if let url = URL(string: weatherURL){

            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { (data, response, error) in

                if error != nil {
                    completion(nil)
                }

                if let data = data {
                    do{
                        let weatherModel = try JSONDecoder().decode(WeatherData.self, from: data)
                        completion(weatherModel)
                    }
                    catch (let error) {
                        print("error decoding \(error)")
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }

            }.resume()
        }

    }

    func fetchWeatherFor3Days(city: String, completion: @escaping (Weather3DayData?) -> Void) {

        let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=07a44fd531e1944590289075b754402c&units=metric"

        if let url = URL(string: weatherURL){

            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { (data, response, error) in

                if error != nil {
                    completion(nil)
                }

                if let data = data {
                    do{
                        let weather3DayDataModel = try JSONDecoder().decode(Weather3DayData.self, from: data)
                        completion(weather3DayDataModel)
                    }
                    catch (let error) {
                        print("error decoding \(error)")
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }

            }.resume()
        }
    }

}



