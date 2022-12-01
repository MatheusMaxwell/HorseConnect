//
//  EmbryoExtensions.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 30/11/22.
//
import CoreData

extension Embryo {
    
    func toMap() -> [String : String]{
        var map = [String: String]()
        map["id"] = self.id
        map["female"] = self.female
        map["femaleId"] = self.femaleId
        map["male"] = self.male
        map["maleId"] = self.maleId
        map["receiver"] = self.receiver
        map["receiverId"] = self.receiverId
        map["date"] = self.date
        map["userId"] = self.userId
        
        return map
    }
    
    func toEntity(context: NSManagedObjectContext){
        let embryo = EmbryoEntity(context: context)
        embryo.id = self.id
        embryo.female = self.female
        embryo.femaleId = self.femaleId
        embryo.male = self.male
        embryo.maleId = self.maleId
        embryo.receiver = self.receiver
        embryo.receiverId = self.receiverId
        embryo.date = self.date
        embryo.userId = self.userId
    }
}
extension [String:Any]{
    
    func toEmbryo(id: String) -> Embryo {
        return Embryo(
            id: id,
            female: self["female"] as! String,
            femaleId: self["femaleId"] as! String,
            male: self["male"] as! String,
            maleId: self["maleId"] as! String,
            receiver: self["receiver"] as! String,
            receiverId: self["receiverId"] as! String,
            date: self["date"] as! String,
            userId: self["userId"] as! String
        )
    }
    
}
