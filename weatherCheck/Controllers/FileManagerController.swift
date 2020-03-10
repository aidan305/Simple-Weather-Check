//
//  FileManagerController.swift
//  weatherCheck
//
//  Created by Aidan Egan on 15/02/2020.
//  Copyright © 2020 Aidan Egan. All rights reserved.
//

import Foundation

class FileManagerController {

    let filename = FileSetupUtility().setUpFile()

    func saveCityToFile(cityArray: [City]) {

        let jsonData = encodeData(arrayOfCities: cityArray)
        writeDatatoFile(jsonData: jsonData)
        readDataFromFile()
    }

    func encodeData(arrayOfCities: [City]) -> Data{

        let jsonEncoder = JSONEncoder()
        var jsonData = Data()

        do{
            jsonData = try jsonEncoder.encode(arrayOfCities)
        }
        catch{
            print("error with JSON encoding")
        }
        return jsonData
    }

    func writeDatatoFile(jsonData: Data){

        do {
            try jsonData.write(to: filename)
        } catch {
            print("error with writing string to file")
        }
    }

    func readDataFromFile() -> [City] {

        //check file exists
        //read the contents of file to string
        //convert string to data
        //use JSON decoder to convert data to city
        //then return decoded city array 

        var decodedCitiesArray = [City]()

        do{
            let fileContentAsString = try String(contentsOf: filename, encoding: .utf8)
            let jsonData = fileContentAsString.data(using: .utf8)!
            decodedCitiesArray = try JSONDecoder().decode([City].self, from: jsonData)
            print(decodedCitiesArray[decodedCitiesArray.count - 1].cityName)
        }
        catch{
            print("error reading file content - file does not exist yet")
        }
        return decodedCitiesArray

    }

    func deleteRowFromFile(updatedArray: [City]){
        let jsonData = encodeData(arrayOfCities: updatedArray)
        writeDatatoFile(jsonData: jsonData)
    }
}

