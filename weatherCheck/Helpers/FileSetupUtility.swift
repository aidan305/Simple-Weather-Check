//
//  FileSetupUtility.swift
//  weatherCheck
//
//  Created by Aidan Egan on 12/02/2020.
//  Copyright © 2020 Aidan Egan. All rights reserved.
//

import Foundation

class FileSetupUtility {

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func setUpFile() -> URL{
        let fileSetupUtility = FileSetupUtility()
        let filename = fileSetupUtility.getDocumentsDirectory().appendingPathComponent("cityList.JSON")
        return filename
    }
}
