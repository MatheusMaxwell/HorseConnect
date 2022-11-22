//
//  GenealogyExtensions.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 22/11/22.
//

import CoreData

extension Genealogy {
    
    func toMap() -> [String: Any] {
        var map = [String:Any]()
        map["father"] = self.father
        map["fatherGrandFather"] = self.fatherGrandFather
        map["fatherGrandFatherGreatGrandFather"] = self.fatherGrandFatherGreatGrandFather
        map["fatherGrandFatherGreatGrandMother"] = self.fatherGrandFatherGreatGrandMother
        map["fatherGrandMother"] = self.fatherGrandMother
        map["fatherGrandMotherGreatGrandFather"] = self.fatherGrandMotherGreatGrandFather
        map["fatherGrandMotherGreatGrandMother"] = self.fatherGrandMotherGreatGrandMother
        map["mother"] = self.mother
        map["motherGrandFather"] = self.motherGrandFather
        map["motherGrandFatherGreatGrandFather"] = self.motherGrandFatherGreatGrandFather
        map["motherGrandFatherGreatGrandMother"] = self.motherGrandFatherGreatGrandMother
        map["motherGrandMother"] = self.motherGrandMother
        map["motherGrandMotherGreatGrandFather"] = self.motherGrandMotherGreatGrandFather
        map["motherGrandMotherGreatGrandMother"] = self.motherGrandMotherGreatGrandMother
        return map
    }
    
    func toEntity(context: NSManagedObjectContext){
        let genealogy = GenealogyEntity(context: context)
        genealogy.id = self.id
        genealogy.father = self.father
        genealogy.fatherGrandFather = self.fatherGrandFather
        genealogy.fatherGrandFatherGreatGrandFather = self.fatherGrandFatherGreatGrandFather
        genealogy.fatherGrandFatherGreatGrandMother = self.fatherGrandFatherGreatGrandMother
        genealogy.fatherGrandMother = self.fatherGrandMother
        genealogy.fatherGrandMotherGreatGrandFather = self.fatherGrandMotherGreatGrandFather
        genealogy.fatherGrandMotherGreatGrandMother = self.fatherGrandMotherGreatGrandMother
        genealogy.mother = self.mother
        genealogy.motherGrandFather = self.motherGrandFather
        genealogy.motherGrandFatherGreatGrandFather = self.motherGrandFatherGreatGrandFather
        genealogy.motherGrandFatherGreatGrandMother = self.motherGrandFatherGreatGrandMother
        genealogy.motherGrandMother = self.motherGrandMother
        genealogy.motherGrandMotherGreatGrandFather = self.motherGrandMotherGreatGrandFather
        genealogy.motherGrandMotherGreatGrandMother = self.motherGrandMotherGreatGrandMother
    }
    
}

extension [Genealogy]{
    
    func toGenealogiesEntity(context: NSManagedObjectContext){
        _ = self.map{
            $0.toEntity(context: context)
        }
    }
    
}

extension [String:Any] {
    
    func toGenealogy(id: String) -> Genealogy {
        return Genealogy(
            id: id,
            father: self["father"] as? String ?? "",
            fatherGrandFather: self["fatherGrandFather"] as? String ?? "",
            fatherGrandFatherGreatGrandFather: self["fatherGrandFatherGreatGrandFather"] as? String ?? "",
            fatherGrandFatherGreatGrandMother: self["fatherGrandFatherGreatGrandMother"] as? String ?? "",
            fatherGrandMother: self["fatherGrandMother"] as? String ?? "",
            fatherGrandMotherGreatGrandFather: self["fatherGrandMotherGreatGrandFather"] as? String ?? "",
            fatherGrandMotherGreatGrandMother: self["fatherGrandMotherGreatGrandMother"] as? String ?? "",
            mother: self["mother"] as? String ?? "",
            motherGrandFather: self["motherGrandFather"] as? String ?? "",
            motherGrandFatherGreatGrandFather: self["motherGrandFatherGreatGrandFather"] as? String ?? "",
            motherGrandFatherGreatGrandMother: self["motherGrandFatherGreatGrandMother"] as? String ?? "",
            motherGrandMother: self["motherGrandMother"] as? String ?? "",
            motherGrandMotherGreatGrandFather: self["motherGrandMotherGreatGrandFather"] as? String ?? "",
            motherGrandMotherGreatGrandMother: self["motherGrandMotherGreatGrandMother"] as? String ?? "")
    }
    
}
