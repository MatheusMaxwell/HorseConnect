//
//  StringExtensions.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 20/11/22.
//

import Foundation

extension String {
    
    func toAnimalTypeDescription() -> String {
        switch(self){
        case AnimalType.stallion.rawValue:
            return "Garanhão"
        case AnimalType.donor.rawValue:
            return "Doadora/Matriz"
        case AnimalType.foal.rawValue:
            return "Potro"
        case AnimalType.competitors.rawValue:
            return "Competidor"
        case AnimalType.promises.rawValue:
            return "Promessa"
        case AnimalType.gelding.rawValue:
            return "Castrado"
        case AnimalType.receivers.rawValue:
            return "Receptora"
        default:
            return ""
        }
    }
    
    func getDateFromIsoDateString() -> String {
        let newFormatter = ISO8601DateFormatter()
        let date = newFormatter.date(from: self)
        
        return date?.formatted().components(separatedBy: " ")[0] ?? ""
    }
}
