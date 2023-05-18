//
//  NetworkData.swift
//  Mantis
//
//  Created by rodoolfo gonzalez on 10-05-23.
//

import Foundation

struct Response: Codable {
    
    var results : [Result]
   
}

struct Result : Codable {
    let website : String
    let status : Int
}



