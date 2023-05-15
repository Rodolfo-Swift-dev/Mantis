//
//  NetworkModel.swift
//  Mantis
//
//  Created by rodoolfo gonzalez on 10-05-23.
//

import Foundation

struct NetworkArray{
    
    let netArray: [NetworkModel]

}

struct NetworkModel {
    
    let web : String
    let status : Int
    var condition : Condition{
       
        switch status{
        case 0:
            return Condition(conditionName: "xmark.circle.fill", conditionString: "Ocupado")
        case 1:
            return Condition(conditionName: "checkmark.circle.fill", conditionString: "Disponible")
        default:
             
            return Condition(conditionName: "exclamationmark.triangle.fill", conditionString: "Error Char.")
        }
    }
}

struct Condition{
    let conditionName : String
    let conditionString : String
    
}
