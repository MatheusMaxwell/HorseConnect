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
        case AnimalType.animalOutside.rawValue:
            return "Animal usado de fora"
        default:
            return ""
        }
    }
    
    func getDateFromIsoDateString() -> String {
        let newFormatter = ISO8601DateFormatter()
        let date = newFormatter.date(from: self)
        
        return date?.formatted().components(separatedBy: " ")[0].replacingOccurrences(of: ",", with: "") ?? ""
    }
    
    func getYearsDifference() -> String{
        let newFormatter = ISO8601DateFormatter()
        if let birthDate = newFormatter.date(from: self){
            let years = Int(birthDate.timeIntervalSinceNow.asYears()) * -1
            var months = Int(birthDate.timeIntervalSinceNow.asMonths()) * -1
            months = months - (12 * years)
            return "\(years) ano(s) e \(months) mes(es)"
        }
        return ""
    }
    
    func getMonths() -> String {
        let newFormatter = ISO8601DateFormatter()
        if let birthDate = newFormatter.date(from: self){
            let months = Int(birthDate.timeIntervalSinceNow.asMonths()) * -1
            return "\(months) mes(es)"
        }
        return ""
    }
    
    func fileName() -> String {
        return (self.components(separatedBy: "%").last?.components(separatedBy: "?").first!) ?? ""
    }
}
