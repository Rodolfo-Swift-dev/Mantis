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
            return Condition(sFSymbolName: "xmark.circle.fill", conditionString: "Ocupado")
        case 1:
            return Condition(sFSymbolName: "checkmark.circle.fill", conditionString: "Disponible")
        default:
             
            return Condition(sFSymbolName: "exclamationmark.triangle.fill", conditionString: "Error Char.")
        }
    }
}

struct Condition{
    let sFSymbolName : String
    let conditionString : String
    
}
