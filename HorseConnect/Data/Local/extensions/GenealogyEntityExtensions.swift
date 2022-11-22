//
//  GenealogyEntityExtensions.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 22/11/22.
//

extension GenealogyEntity {
    
    func toGenealogy() -> Genealogy {
        return Genealogy(id: self.id ?? "", father: self.father ?? "", fatherGrandFather: self.fatherGrandFather ?? "", fatherGrandFatherGreatGrandFather: self.fatherGrandMotherGreatGrandFather ?? "", fatherGrandFatherGreatGrandMother: self.fatherGrandFatherGreatGrandMother ?? "", fatherGrandMother: self.fatherGrandMother ?? "", fatherGrandMotherGreatGrandFather: self.fatherGrandMotherGreatGrandFather ?? "", fatherGrandMotherGreatGrandMother: self.fatherGrandMotherGreatGrandMother ?? "", mother: self.mother ?? "", motherGrandFather: self.motherGrandFather ?? "", motherGrandFatherGreatGrandFather: self.motherGrandFatherGreatGrandFather ?? "", motherGrandFatherGreatGrandMother: self.motherGrandFatherGreatGrandMother ?? "", motherGrandMother: self.motherGrandMother ?? "", motherGrandMotherGreatGrandFather: self.motherGrandMotherGreatGrandFather ?? "", motherGrandMotherGreatGrandMother: self.motherGrandMotherGreatGrandMother ?? "")
    }
    
}

extension [GenealogyEntity] {
    
    func toGenealogies() -> [Genealogy] {
        return self.map{
            $0.toGenealogy()
        }
    }
    
}
