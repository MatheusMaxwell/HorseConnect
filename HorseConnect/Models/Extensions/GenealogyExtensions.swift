//
//  GenealogyExtensions.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 22/11/22.
//

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
