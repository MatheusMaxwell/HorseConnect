//
//  FarmDataEntityExtensions.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 22/11/22.
//

extension FarmDataEntity {
    
    func toFarmData() -> FarmData {
        return FarmData(farmName: self.farmName ?? "", imageLogoUrl: self.imageLogoUrl ?? "", primaryColor: self.primaryColor ?? "")
    }
    
}

