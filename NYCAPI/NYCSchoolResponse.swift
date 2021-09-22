//
//  NYCSchoolResponse.swift
//  NycSchools
//
//  Created by Nathaniel Whittington on 9/22/21.
//

import Foundation

typealias Response = [[String: String]]



struct School {
    var primary_address_line_1 : String
    var school_name : String
    var phone_number : String
         
}

struct NewYorkSchool {
    var school : [School]
}
