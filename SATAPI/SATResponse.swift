//
//  SATResponse.swift
//  NycSchools
//
//  Created by Nathaniel Whittington on 9/22/21.
//

import Foundation

//This is my parse JSON I created based on the data returned from the api.
struct SATScore: Codable {
    let dbn : String
    let schoolName : String
    let numOfSatTestTakers : String
    let satCriticalReadingAvgScore: String
    let satMathAvgScore : String
    let satWritingAvgScore: String
}


