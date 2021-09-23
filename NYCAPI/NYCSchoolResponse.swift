//
//  NYCSchoolResponse.swift
//  NycSchools
//
//  Created by Nathaniel Whittington on 9/22/21.
//

import Foundation


//This is my parse Json I created based on the data returned from the api.
struct NewYorkSchool : Codable {
    let schoolName : String
    let phoneNumber : String
    let location : String
    let dbn: String
}
