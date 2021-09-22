//
//  SATResponse.swift
//  NycSchools
//
//  Created by Nathaniel Whittington on 9/22/21.
//

import Foundation


struct SATScore: Codable {
   
    let schoolName : String
    let numOfSatTestTakers : String
    let satCriticalReadingAvgScore: String
    let satMathAvgScore : String
     let satWritingAvgScore: String

    enum CodingKeys: String, CodingKey {
    
        case schoolName = "school_name"
        case numOfSatTestTakers = "num_of_sat_test_takers"
        case satCriticalReadingAvgScore = "sat_critical_reading_avg_score"
        case satMathAvgScore = "sat_math_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
    }
}

typealias SAT = [SATScore]
