//
//  AnimalExtensions.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 19/11/22.
//

extension Animal {
    
    func toMap() -> [String:Any]{
        var map = [String:Any]()
        map["name"] = self.name
        map["imageId"] = self.imageId
        map["imageUrl"] = self.imageUrl
        map["birthDate"] = self.birthDate
        map["coat"] = self.coat
        map["sex"] = self.sex
        map["isLive"] = self.isLive
        map["types"] = self.types?.joined(separator: ",")
        map["userId"] = self.userId
        return map
    }
}

extension [String:Any]{
    
    func toAnimal(id: String) -> Animal {
        return Animal(
            id: id,
            name: self["name"] as? String ?? "",
            imageId: self["imageId"] as? String ?? "",
            imageUrl: self["imageUrl"] as? String ?? "",
            birthDate: self["birthDate"] as? String ?? "",
            coat: self["coat"] as? String ?? "",
            sex: self["sex"] as? String ?? "",
            isLive: self["isLive"] as? Bool ?? true,
            types: (self["types"] as? String ?? "").components(separatedBy: ","),
            userId: self["userId"] as? String ?? ""
        )
    }
    
}
