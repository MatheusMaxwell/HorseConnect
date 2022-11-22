//
//  FarmDataExtensions.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 11/11/22.
//

import CoreData

extension FarmData {
    
    func toMap() -> [String:Any] {
        var map = [String:Any]()
        map["farmName"] = self.farmName
        map["primaryColor"] = self.primaryColor
        map["imageLogoUrl"] = self.imageLogoUrl
        return map
    }
    
    func toEntity(context: NSManagedObjectContext, id: String) {
        let farmData = FarmDataEntity(context: context)
        
        farmData.id = id
        farmData.farmName = self.farmName
        farmData.imageLogoUrl = self.imageLogoUrl
        farmData.primaryColor = self.primaryColor
    }
}

extension [String:Any]{
    
    func toFarmData() -> FarmData {
        return FarmData(
            farmName: self["farmName"] as? String ?? "",
            imageLogoUrl: self["imageLogoUrl"] as? String ?? "",
            primaryColor: self["primaryColor"] as? String ?? ""
        )
    }
}
