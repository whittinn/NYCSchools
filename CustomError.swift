//
//  CustomError.swift
//  NycSchools
//
//  Created by Nathaniel Whittington on 9/22/21.
//

import Foundation
//I created a custom error of type String, protocol Error to provide a customized message if no sat score are provided by the sat api, or if the case of unable to get data.
enum CustomError: String, Error  {
  
    //case emptySatScore represents a string.
    case emptySATScore = "This school has no sat scores"
    case unableToGetData = "Unable to retrieve data"
}
